#!/usr/bin/with-contenv bashio

FREQUENCY=$(bashio::config 'frequency')
echo "frequency" $FREQUENCY

DEVICE=$(bashio::config 'device')
echo "device" $DEVICE

# MQTT_PREFIX=$(bashio::config 'discovery_prefix_mqtt')
MQTT_HOST=$(bashio::services mqtt "host")
MQTT_USER=$(bashio::services mqtt "username")
MQTT_PASSWORD=$(bashio::services mqtt "password")
echo $MQTT_HOST $MQTT_USER $MQTT_PASSWORD
# TOPIC=$(bashio::config 'topic_parent')
# TYPE=$(bashio::config 'trigger_type')
# SUBTYPE=$(bashio::config 'trigger_subtype')
# MANUFACTURER=$(bashio::config 'manufacturer')
# DEVICE_NAME=$(bashio::config 'device_name')
# ID=$(bashio::config 'id')
# MODEL=$(bashio::config 'model')

# MESSAGE="{\"automation_type\":\"trigger\",\"topic\":\"rtl_433/time\",\"type\":\"${TYPE}\",\"subtype\":\"${SUBTYPE}\",\"device\":{\"manufacturer\":\"${MANUFACTURER}\",\"name\":\"${DEVICE_NAME}\",\"identifiers\":\"${ID}\",\"model\":\"${MODEL}\"}}"
mosquitto_pub -h $MQTT_HOST -u $MQTT_USER -p $MQTT_PASSWORD -t "test" -m "test"

# echo "TEST2"

# /usr/local/bin/rtl_433 -f $FREQUENCY -R $DEVICE -F "mqtt://${MQTT_HOST},user=${MQTT_USER},pass=${MQTT_PASSWORD},devices=${TOPIC}" -F kv -M level