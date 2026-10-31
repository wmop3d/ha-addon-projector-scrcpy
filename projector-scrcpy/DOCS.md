# Projector scrcpy

Streams an Android TV device's screen to the browser and lets you control
it with mouse and keyboard, using ws-scrcpy (enhanced fork, scrcpy server
3.3.4) over network ADB. Built to navigate the Nebula projector's menus
from a Home Assistant dashboard.

## Option

- `device_address` — `host:port` of the projector's ADB endpoint
  (default `192.168.50.23:5555`). The projector must have ADB debugging
  enabled (Developer options).

## First run

The add-on generates its own ADB key in its persistent `/data` volume.
The first connection makes the projector show an "Allow USB debugging?"
prompt — accept it with "Always allow" using the projector's remote.
After that, connections are automatic.

## Access

- Sidebar panel (ingress) or the add-on's "Open Web UI" button.
- Direct on the LAN: `http://<home-assistant-host>:8000`.
- Pick the device in the list to open its stream. Clicks, drags and
  keyboard input are forwarded to the device; the toolbar has
  Home/Back/Recent and other hardware keys.

## Limits

- DRM-protected video (Netflix and similar during playback) renders
  black in the stream. Menus, launchers and non-DRM apps mirror normally.
- One scrcpy stream at a time per viewer is fine; multiple viewers can
  watch, but they share one control channel.
