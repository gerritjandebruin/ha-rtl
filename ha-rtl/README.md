# RTL433 to Home Assistant
[aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg
[amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg
[armhf-shield]: https://img.shields.io/badge/armhf-yes-green.svg
[armv7-shield]: https://img.shields.io/badge/armv7-yes-green.svg
[i386-shield]: https://img.shields.io/badge/i386-yes-green.svg

A Home Assistant addon for a software defined radio tuned to listen for RF transmissions and convert them into [device triggers](https://www.home-assistant.io/integrations/device_trigger.mqtt/).
This device trigger can be used to trigger any automation as soon as a specific message is received.
For example, the add-on allows to integrate the [KAKU ACDB-7000A](https://klikaanklikuit.nl/product/draadloze-drukknop/) to be used in Home Assistant.
Setup is done automatically via [MQTT Discovery](https://www.home-assistant.io/docs/mqtt/discovery/).

This hass.io addon is based on https://hub.docker.com/r/hertzg/rtl_433, which is based on the well-known rtl_433 library (https://github.com/merbanan/rtl_433).
Compared to https://github.com/pbkhrv/rtl_433-hass-addons, this add-on has a few differences:
- Configuration is done via the configuration tab of the addon.
- In default mode, logging is done via the logging tab of the addon.
- The addon is a [pre-built container](https://hub.docker.com/u/gerritjandebruin), allowing much faster installation.
- This addon provides currently only device_triggers, which are well suited for buttons, remote controls, etc.

If anything does not work, or you have trouble using your own RF device, please raise an [issue](https://github.com/gerritjandebruin/doorbell/issues).

## Usage

1) Install the addon by adding the repository https://github.com/gerritjandebruin/ha-rtl in the add-on store. Or use this button:
[![Open your Home Assistant instance and show the add add-on repository dialog with a specific repository URL pre-filled.](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https%3A%2F%2Fgithub.com%2Fgerritjandebruin%2Fha-rtl)

2) Connect to a USB RTL-SDR Dongle supported by [rtl_433](https://github.com/merbanan/rtl_433). For example [this](https://nl.aliexpress.com/item/32476877972.html?spm=a2g0s.9042311.0.0.70924c4d9vmXSr) item.

3) Use addon configuration to configure:
- device (or protocol, look [here](https://github.com/merbanan/rtl_433))
- frequency
- manufacturer
- device_name
- model

All other configurations can be left unchanged.

4) Start the addon.

## Hardware

This has been tested and used with the following hardware:
- KAKU ACDB-7000A (https://www.gamma.nl/assortiment/klikaanklikuit-deurbel-set-acdb-6600ac/p/B413295)  
- cheap rtl receiver ([aliexpress.com](https://aliexpress.com/item/32476877972.html))
- HASS.IO on old laptop, see https://github.com/gerritjandebruin/home-assistant

Total costs: +- €35, including chime and doorbell that work also when HA is down.

![My hardware used for this addon.](https://github.com/gerritjandebruin/ha-rtl/raw/master/ha-rtl/hardware.png)

## Automations
To use this device in automations, please make use of the visual editor and choose under trigger for "Device".
You should see your device as soon as the add-on starts.

In my case, I create a notification for every device that the doorbell rang, see https://github.com/gerritjandebruin/home-assistant/blob/a1145e7b9ec0b38e20aaa4893a0365a1e106976e/automations.yaml#L248.

## Contact
Open an issue if needed.

## To do
- support different device_classes
- add support for more than one device at the same time