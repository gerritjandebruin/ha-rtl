#!/usr/bin/with-contenv bashio

FREQUENCY=$(bashio::config 'frequency')
DEVICE=$(bashio::config 'device')

MQTT_PREFIX=$(bashio::config 'discovery_prefix_mqtt')
MQTT_HOST=$(bashio::services mqtt "host")
MQTT_USER=$(bashio::services mqtt "username")
MQTT_PASSWORD=$(bashio::services mqtt "password")
TOPIC=$(bashio::config 'topic_parent')
TYPE=$(bashio::config 'trigger_type')
SUBTYPE=$(bashio::config 'trigger_subtype')
MANUFACTURER=$(bashio::config 'manufacturer')
DEVICE_NAME=$(bashio::config 'device_name')
ID=$(bashio::config 'id')
MODEL=$(bashio::config 'model')

TOPIC_DISCOVERY="${MQTT_PREFIX}/${ID}/config"
MESSAGE_DISCOVERY="{\"automation_type\":\"trigger\",\"topic\":\"${TOPIC}/time\",\"type\":\"${TYPE}\",\"subtype\":\"${SUBTYPE}\",\"device\":{\"manufacturer\":\"${MANUFACTURER}\",\"name\":\"${DEVICE_NAME}\",\"identifiers\":\"${ID}\",\"model\":\"${MODEL}\"}}"
mosquitto_pub -h $MQTT_HOST -u $MQTT_USER -P $MQTT_PASSWORD -t $TOPIC_DISCOVERY -m $MESSAGE_DISCOVERY

/usr/local/bin/rtl_433 -f $FREQUENCY -R $DEVICE -F "mqtt://${MQTT_HOST},user=${MQTT_USER},pass=${MQTT_PASSWORD},devices=${TOPIC}" -F kv -M level