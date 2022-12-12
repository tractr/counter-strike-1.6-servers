# Source Dockerfile: https://github.com/CajuCLC/cstrike-docker/blob/main/Dockerfile
# Source branch: https://github.com/CajuCLC/cstrike-docker
FROM cajuclc/cstrike-docker:latest as classic

# Remove env variables (set in entrypoint.sh)
RUN unset PORT
RUN unset MAP
RUN unset MAXPLAYERS
RUN unset SV_LAN

# Need privilege
USER root

# install dependencies
RUN apt-get update && \
    apt-get install -y nginx

# configure nginx to allow for FastDownload
RUN mv /etc/nginx/sites-available/default /etc/nginx/sites-available/default.backup && \
    bash -c "mkdir -p /srv/cstrike/{gfx,maps,models,overviews,sound,sprites}/nothing-here"
COPY nginx.conf /etc/nginx/sites-available/default

# add entrypoint
ADD entrypoint.sh /bin/entrypoint.sh
RUN chmod +x /bin/entrypoint.sh
ENTRYPOINT ["/bin/entrypoint.sh"]

# add server config
COPY configs/classic/server.cfg /home/steam/cstrike/cstrike/server.cfg
COPY configs/classic/maps.ini /home/steam/cstrike/cstrike/addons/amxmodx/configs/maps.ini
COPY configs/classic/podbot.cfg /home/steam/cstrike/cstrike/addons/podbot/podbot.cfg

FROM classic as melee

# add server config
COPY configs/melee/server.cfg /home/steam/cstrike/cstrike/server.cfg
COPY configs/melee/maps.ini /home/steam/cstrike/cstrike/addons/amxmodx/configs/maps.ini

FROM classic as deathmatch-team

RUN apt-get update && \
    apt-get install -y unzip

# Add mod
COPY mods/csdm-2.1.zip /csdm-2.1.zip
RUN unzip -o /csdm-2.1.zip -d /home/steam/cstrike

# add server config
COPY configs/deathmatch-team/server.cfg /home/steam/cstrike/cstrike/server.cfg
COPY configs/deathmatch-team/maps.ini /home/steam/cstrike/cstrike/addons/amxmodx/configs/maps.ini
COPY configs/deathmatch-team/csdm.cfg /home/steam/cstrike/cstrike/addons/amxmodx/configs/csdm.cfg
COPY configs/deathmatch-team/plugins-csdm.ini /home/steam/cstrike/cstrike/addons/amxmodx/configs/plugins-csdm.ini

RUN apt-get remove -y unzip

FROM deathmatch-team as deathmatch-ffa

# add server config
COPY configs/deathmatch-ffa/csdm.cfg /home/steam/cstrike/cstrike/addons/amxmodx/configs/csdm.cfg