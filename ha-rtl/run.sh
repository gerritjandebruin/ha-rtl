#!/usr/bin/with-contenv bashio

# MQTT
prefix=$(bashio::config 'discovery_prefix_mqtt')
host=$(bashio::services mqtt "host")
user=$(bashio::services mqtt "username")
password=$(bashio::services mqtt "password")

args=(
    -H $(bashio::config 'hop_interval')
    -F "mqtt://${host},user=${user},pass=${password},devices=${prefix}/rtl433/action"
    -F "kv"
    -M "level" 
    -M "protocol"
)

for frequency in $(bashio::config 'frequencies'); do
    args+=(-f $frequency)
done

for device in $(bashio::config 'devices|keys'); do
    protocol=$(bashio::config "devices[${device}].protocol")
    atype=$(bashio::config "devices[${device}].automation_type")
    type=$(bashio::config "devices[${device}].trigger_type")
    stype=$(bashio::config "devices[${device}].trigger_subtype")
    mf=$(bashio::config "devices[${device}].manufacturer")
    name=$(bashio::config "devices[${device}].name")
    mdl=$(bashio::config "devices[${device}].model")
    
    if $(bashio::var.equals "$atype" "device_automation"); then
        atype="trigger"
        if $(bashio::config.exists "devices[${device}].id"); then
            t="${prefix}/rtl433/action/id"
            pl=$(bashio::config "devices[${device}].id")
            id=$pl
        else
            t="${prefix}/rtl433/action/protocol"
            pl=$protocol
            id="0"
        fi

        ids="[\"rtl433\",\"${id}\",\"${protocol}\"]"
        bashio::log.blue "Used ids: ${ids}"

        args+=(-R $protocol)
        mosquitto_pub -h ${host} -u ${user} -P ${password} -t "${prefix}/device_automation/rtl433/1/config" -m "{\"atype\":\"${atype}\",\"pl\":${pl},\"t\":\"${t}\",\"type\":\"${type}\",\"stype\":\"${stype}\",\"dev\":{\"mf\":\"${mf}\",\"name\":\"${name}\",\"ids\":${ids},\"mdl\":\"${mdl}\"}}"
    else
        bashio::exit.nok "Invalid automation_type: ${atype}"
    fi
done

/usr/local/bin/rtl_433 "${args[@]}"
