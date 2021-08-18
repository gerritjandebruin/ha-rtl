# RTL433 to Home Assistant
A Home Assistant addon for a software defined radio tuned to listen for RF transmissions and convert them into [device triggers](https://www.home-assistant.io/integrations/device_trigger.mqtt/).
This hass.io addon is based on https://hub.docker.com/r/hertzg/rtl_433, which is based on the well-known rtl_433 library (https://github.com/merbanan/rtl_433).

With default configuration, it is designed to work specifically for the KAKU ACDB-7000A (https://klikaanklikuit.nl/product/draadloze-drukknop/).
Any RF transmission based trigger should work as well with the correct configuarion.
Setup is done automatically via [MQTT Discovery](https://www.home-assistant.io/docs/mqtt/discovery/).
If anything does not work, or you have trouble using your own RF device, please raise an [issue](https://github.com/gerritjandebruin/doorbell/issues).

## Usage

1) Install the addon.
2) Connect to a USB RTL-SDR Dongle supported by https://github.com/merbanan/rtl_433.
3) Use addon configuration to configure:
- device (or protocol, see https://github.com/merbanan/rtl_433 for more details inc protocol IDs, default 51)
- frequency
- manufacturer
- device_name
- model
All other configurations can be left unchanged.

3) Start the addon.

## Hardware

This has been tested and used with the following hardware:
- KAKU ACDB-7000A (https://www.gamma.nl/assortiment/klikaanklikuit-deurbel-set-acdb-6600ac/p/B413295)  
- cheap rtl receiver ([aliexpress.com](https://aliexpress.com/item/32476877972.html))
- HASS.IO on old laptop, see https://github.com/gerritjandebruin/home-assistant

Total costs: +- €35, including chime and doorbell that work also when HA is down.

## Automations
To use this device in automations, please make use of the visual editor and choose under trigger for "Device".
You should see your device as soon as the add-on starts.

In my case, I create a notification for every device that the doorbell rang, see https://github.com/gerritjandebruin/home-assistant/blob/a1145e7b9ec0b38e20aaa4893a0365a1e106976e/automations.yaml#L248.

## Contact
Open an issue if needed.
