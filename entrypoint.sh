#!/usr/bin/env bash

# Apply default envs
PORT="${PORT:-27015}"
SV_LAN="${SV_LAN:-0}"
SERVER_NAME="${SERVER_NAME:-Counter-Strike 1.6 Server}"
MAXPLAYERS="${MAXPLAYERS:-16}"
BOTS_FILL="${BOTS_FILL:-0}"

# Build options list
OPTIONS=( "-game" "cstrike" "-strictportbind" "-ip" "0.0.0.0" "-port" "${PORT}" "-maxplayers" "${MAXPLAYERS}" "+hostname" "${SERVER_NAME}" "+sv_lan" "${SV_LAN}" )

if [ -n "${MAP}" ]; then
    OPTIONS+=("+map" "${MAP}")
fi

if [ -n "${DOWNLOAD_URL}" ]; then
    OPTIONS+=("-sv_downloadurl" "${DOWNLOAD_URL}")
fi

# Add bots.
sed -i "s/{BOTS_FILL}/${BOTS_FILL}/g" /home/steam/cstrike/cstrike/addons/podbot/podbot.cfg
# If BOT_FILL is 0, then remove the line `pb fillserver 100` from podbot.cfg
if [ "${BOTS_FILL}" -eq 0 ]; then
    sed -i "/pb fillserver 100/d" /home/steam/cstrike/cstrike/addons/podbot/podbot.cfg
fi


# Start frontend
service nginx start;

# Start server
./hlds_run "${OPTIONS[@]}"
