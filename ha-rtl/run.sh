#!/usr/bin/with-contenv bashio

# MQTT
prefix=$(bashio::config 'discovery_prefix_mqtt')
host=$(bashio::services mqtt "host")
user=$(bashio::services mqtt "username")
password=$(bashio::services mqtt "password")

args=(
    -H $(bashio::config 'hop_interval')
    -F "kv"
    -M "level" 
    -M "protocol"
)

house_code=false
for device in $(bashio::config 'devices|keys'); do
    if $(bashio::config.exists "devices[${device}].house_code"); then
        args+=(-F "mqtt://${host},user=${user},pass=${password},devices=${prefix}/rtl433/[id]")
        house_code=true
        break
    fi
done
echo $house_code
if ! $house_code; then
    args+=(-F "mqtt://${host},user=${user},pass=${password},devices=${prefix}/rtl433/[protocol]")
fi

for frequency in $(bashio::config 'frequencies'); do
    args+=(-f $frequency)
done

for device in $(bashio::config 'devices|keys'); do
    protocol=$(bashio::config "devices[${device}].protocol")
    automation_type=$(bashio::config "devices[${device}].automation_type")
    trigger_type=$(bashio::config "devices[${device}].trigger_type")
    trigger_subtype=$(bashio::config "devices[${device}].trigger_subtype")
    manufacturer=$(bashio::config "devices[${device}].manufacturer")
    name=$(bashio::config "devices[${device}].name")
    id=$(bashio::config "devices[${device}].id")
    model=$(bashio::config "devices[${device}].model")
    
    if [ "$automation_type" == "device_automation" ]; then
        automation_type="trigger"
        if $(bashio::config.exists "devices[${device}].house_code"); then
            house_code=$(bashio::config "devices[${device}].house_code")
            topic="${prefix}/rtl433/${house_code}"
        else
            topic="${prefix}/rtl433/${protocol}"
        fi
    else
        bashio::exit.nok "Invalid automation_type: ${automation_type}"
    fi

    args+=(-R $protocol)

    mosquitto_pub -h ${host} -u ${user} -P ${password} -t "${prefix}/rtl433/config" \
        -m "{\"automation_type\":\"${automation_type}\",\"payload\":${protocol},\"topic\":\"${topic}\",\"type\":\"${trigger_type}\",\"subtype\":\"${trigger_subtype}\",\"device\":{\"manufacturer\":\"${manufacturer}\",\"name\":\"${name}\",\"identifiers\":\"${id}\",\"model\":\"${model}\"}}"
done

/usr/local/bin/rtl_433 "${args[@]}"
