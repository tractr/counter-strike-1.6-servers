#!/usr/bin/env bash

# Start frontend
service nginx start;

./hlds_run -game cstrike -strictportbind -ip 0.0.0.0 -port ${PORT} +sv_lan ${SV_LAN} +map ${MAP} -maxplayers ${MAXPLAYERS} -sv_downloadurl "${DOWNLOAD_URL}" +hostname "${SERVER_NAME}"
