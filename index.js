const argv = require('minimist')(process.argv.slice(2), {
  string: ['mqtt-url', 'whitelist', 'whitelist-macs', 'mqtt-prefix']
});
const noble = require('noble');
const mqtt = require('mqtt');
const mqttClient = mqtt.connect(argv['mqtt-url']);
const whitelist = argv.whitelist.split(',');
const whitelistMacs = argv['whitelist-macs'].split(',')
const MQTT_PREFIX = argv['mqtt-prefix'] || 'home/location';
mqttClient.on('connect', () => {
  console.log('mqtt client connected');
}).on('error', (err) => {
  console.error(err);
});
noble.on('stateChange', (state) => {
  if (state === 'poweredOn') {
    noble.startScanning();
  } else {
    noble.stopScanning();
  }
});
noble.on('discover', (peripheral) => {
  if (whitelist.includes(peripheral.id)) {
    mqttClient.publish(`${MQTT_PREFIX}/${peripheral.id}`, 'home');
  }
  if (whitelistMacs.includes(peripheral.address)) {
    mqttClient.publish(`${MQTT_PREFIX}/${peripheral.address}`, 'home');
  }
});