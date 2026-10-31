# Projector scrcpy — Home Assistant add-on repository

Custom add-on repository for one add-on:

- **Projector scrcpy** — streams an Android TV device's screen (a Nebula
  Capsule 3 Laser projector) to the browser with full remote control, using
  [ws-scrcpy](https://github.com/Mel0nFish/ws-scrcpy-enhanced) over ADB.
  Built for navigating menus from a Home Assistant dashboard.

## Install

1. Home Assistant → Settings → Add-ons → Add-on store → ⋮ → Repositories →
   add `https://github.com/wmop3d/ha-addon-projector-scrcpy`
2. Install **Projector scrcpy**, set the device address option if your
   projector is not at the default, and start it.
3. The first time it connects, the projector shows an "Allow USB debugging?"
   prompt for this add-on's ADB key. Accept it (with "Always allow") using
   the projector's remote.
4. Open the add-on's web UI (or http://\<HA host\>:8000 on the LAN) and pick
   the device to start streaming.

Notes:

- Menus and navigation mirror fine. DRM-protected video (e.g. Netflix
  playback) renders black in any mirror — that is an Android content
  protection rule, not a bug.
- The add-on keeps its ADB key in its persistent `/data` volume, so the
  projector's approval survives restarts.
