#!/usr/bin/with-contenv bashio

# RTL_433 SETTINGS
FREQUENCY=$(bashio::config 'frequency')
PROTOCOL=$(bashio::config 'device')

# AUTO DISCOVERY
MQTT_PREFIX=$(bashio::config 'discovery_prefix_mqtt')

# MQTT
MQTT_HOST=$(bashio::services mqtt "host")
MQTT_USER=$(bashio::services mqtt "username")
MQTT_PASSWORD=$(bashio::services mqtt "password")

# DEVICE SETTINGS
TYPE=$(bashio::config 'trigger_type')
SUBTYPE=$(bashio::config 'trigger_subtype')
MANUFACTURER=$(bashio::config 'manufacturer')
DEVICE_NAME=$(bashio::config 'device_name')
MODEL=$(bashio::config 'model')
IDENTIFIERS=$(bashio::config 'identifiers')

MESSAGE_DISCOVERY="{\"automation_type\":\"trigger\",\"topic\":\"${MQTT_PREFIX}/rtl433/time\",\"type\":\"${TYPE}\",\"subtype\":\"${SUBTYPE}\",\"device\":{\"manufacturer\":\"${MANUFACTURER}\",\"name\":\"${DEVICE_NAME}\",\"identifiers\":\"${IDENTIFIERS}\",\"model\":\"${MODEL}\"}}"
mosquitto_pub -h $MQTT_HOST -u $MQTT_USER -P $MQTT_PASSWORD -t $"${MQTT_PREFIX}/rtl433/config" -m $MESSAGE_DISCOVERY

echo "TEST"
echo $PROTOCOL

if $PROTOCOL == ""
then
    echo "Nothing"
else
    echo "Error"
fi

# /usr/local/bin/rtl_433 -f $FREQUENCY -R $PROTOCOL -F "mqtt://${MQTT_HOST},user=${MQTT_USER},pass=${MQTT_PASSWORD},devices=${TOPIC_STATE}" -F kv -M level