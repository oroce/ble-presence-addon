ble-tracker-addon
=====

BLE Tracker addon for hass.io

# Configuration

```
"mqtt": {
    "prefix": "home/location",
    "url": "mqtt://localhost:1883"
  },
  "whitelist-macs": ["e0:79:93:26:4f:c2"],
  "whitelist": []
}
```

`whitelist-macs`: array of mac addresses

`whitelist`: array of device names


# Building

## Locally

`docker build --build-arg BUILD_FROM="homeassistant/amd64-base:latest" -t local/ble-presence-addon:latest .`

## Remotely

`docker build --build-arg BUILD_FROM="homeassistant/amd64-base:latest" -t ble-presence-addon:latest github.com/oroce/ble-presence-addon`

# License

MIT