# Changelog

## 0.1.1

- Fix image build failing with "npm: not found": the build no longer
  relies on the base image shipping node/npm. Base is now plain
  alpine:3.21 for every arch, with nodejs (runtime) and npm (build-time,
  removed after the build) installed via apk.

## 0.1.0

- First version. ws-scrcpy (Mel0nFish/ws-scrcpy-enhanced @ 32e58f9,
  scrcpy server 3.3.4) packaged as a Home Assistant add-on.
- Background ADB connect loop to the configured projector address;
  ADB key persisted in /data so the projector's approval survives restarts.
- WebRTC proxy middleware removed (unmaintained native `wrtc` dependency);
  remote shell, devtools and file-listing features trimmed from the build.
