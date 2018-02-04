#!/bin/bash
set -e

CONFIG_PATH=./data/options.json

MQTT_URL=$(jq --raw-output ".mqtt.url" $CONFIG_PATH)
MQTT_PREFIX=$(jq --raw-output ".mqtt.prefix" $CONFIG_PATH)
WHITELIST=$(jq --raw-output '.whitelist | join(",")' $CONFIG_PATH)
WHITELIST_MACS=$(jq --raw-output '."whitelist-macs" | join(",")' $CONFIG_PATH)

npm install
node index.js \
    --mqtt-url="${MQTT_URL}" \
    --mqtt-prefix="${MQTT_PREFIX}" \
    --whitelist="${WHITELIST}" \
    --whitelist-macs="${WHITELIST_MACS}"