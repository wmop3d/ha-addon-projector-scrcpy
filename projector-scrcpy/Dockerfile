ARG BUILD_FROM
FROM ${BUILD_FROM}

ENV LANG=C.UTF-8 \
    HOME=/data \
    WS_SCRCPY_CONFIG=/opt/ws-scrcpy/config.yaml

# Runtime deps: adb (android-tools) talks to the projector and serves the
# local ADB server ws-scrcpy's tracker connects to. bash + jq for run.sh.
RUN apk add --no-cache android-tools bash jq

ARG WSSCRCPY_REPOSITORY=https://github.com/Mel0nFish/ws-scrcpy-enhanced.git
ARG WSSCRCPY_COMMIT=32e58f9aa330bb30454d9fe31251c550008fc373

WORKDIR /opt
RUN apk add --no-cache --virtual .build-deps git \
    && git clone ${WSSCRCPY_REPOSITORY} ws-scrcpy \
    && cd ws-scrcpy \
    && git checkout ${WSSCRCPY_COMMIT} \
    && apk del .build-deps

# Feature trims (no remote shell / devtools / file listing in the add-on).
COPY build.config.override.json /opt/ws-scrcpy/build.config.override.json

WORKDIR /opt/ws-scrcpy
# The WebRTC proxy middleware is dropped: its wrtc dependency is an
# unmaintained native module with no current prebuilds, and that streaming
# mode is not used here. Removing its only import keeps it out of the
# bundle. --ignore-scripts is safe for the same reason: every runtime
# dependency of the trimmed build is pure JavaScript (verified: dist
# package.json lists only adbkit, express, portfinder, tslib, ws, yaml).
RUN sed -i "/WebRtcScrcpyProxy.*await import/d; /mwList.push(WebRtcScrcpyProxy)/d" src/server/index.ts \
    && npm ci --ignore-scripts --no-audit --no-fund \
    && npm run dist \
    && npm prune --omit=dev \
    && cp -a node_modules dist/node_modules \
    && rm -rf /root/.npm .git

COPY ws-scrcpy-config.yaml /opt/ws-scrcpy/config.yaml
COPY run.sh /run.sh
RUN chmod a+x /run.sh

WORKDIR /opt/ws-scrcpy/dist
CMD ["/run.sh"]
