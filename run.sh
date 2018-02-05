#!/bin/sh
set -e

CONFIG_PATH=/data/options.json

# TODO: remove this check once everything is working
if [ ! -f "$CONFIG_PATH" ]; then
  mkdir -p `dirname $CONFIG_PATH`
  echo '{"mqtt":{"prefix":"home/location","url":"mqtt://localhost:1883"},"whitelist-macs":[],"whitelist":[]}' >$CONFIG_PATH
fi
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