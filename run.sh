#!/usr/bin/with-contenv bashio

/usr/local/bin/rtl_433 -f 433920000 -R 51 -F "mqtt://192.168.1.251:1883,user=bruingjde,pass=lose_truck,devices=rtl_433" -F kv