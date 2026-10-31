#!/bin/bash
# Projector scrcpy add-on entrypoint.
# - Keeps an ADB server running (its key lives in /data/.android, which
#   persists across restarts, so the projector's one-time "Allow USB
#   debugging?" approval sticks).
# - Keeps a background ADB connection to the configured device alive;
#   ws-scrcpy's tracker picks the device up from the ADB server.
# - Runs the ws-scrcpy web server in the foreground.
set -u

DEVICE="$(jq -r '.device_address // empty' /data/options.json 2>/dev/null)"
if [ -z "${DEVICE}" ]; then
  DEVICE="192.168.50.23:5555"
fi

mkdir -p /data/.android

echo "[projector-scrcpy] Starting ADB server..."
adb start-server

(
  while true; do
    state="$(adb -s "${DEVICE}" get-state 2>/dev/null || true)"
    if [ "${state}" != "device" ]; then
      echo "[projector-scrcpy] Connecting to ${DEVICE} (state: ${state:-unreachable})..."
      adb connect "${DEVICE}" >/dev/null 2>&1 || true
    fi
    sleep 15
  done
) &

echo "[projector-scrcpy] Starting ws-scrcpy for device ${DEVICE}..."
cd /opt/ws-scrcpy/dist
exec node ./index.js
