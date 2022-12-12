# Source Dockerfile: https://github.com/jimtouz/counter-strike-docker/blob/add_bot_support/Dockerfile
# Source branch: https://github.com/jimtouz/counter-strike-docker/tree/add_bot_support
FROM cajuclc/cstrike-docker:latest as classic

# install dependencies
USER root
RUN apt-get update && \
    apt-get -y install nginx

# configure nginx to allow for FastDownload
RUN mv /etc/nginx/sites-available/default /etc/nginx/sites-available/default.backup && \
    bash -c "mkdir -p /srv/cstrike/{gfx,maps,models,overviews,sound,sprites}/nothing-here"
COPY nginx.conf /etc/nginx/sites-available/default

# add entrypoint
ADD entrypoint.sh /bin/entrypoint.sh
RUN chmod +x /bin/entrypoint.sh
ENTRYPOINT ["/bin/entrypoint.sh"]

USER steam

# add server config
COPY configs/classic/server.cfg /home/steam/cstrike/cstrike/server.cfg
COPY configs/classic/maps.ini /home/steam/cstrike/cstrike/addons/amxmodx/configs/maps.ini
COPY configs/classic/podbot.cfg /home/steam/cstrike/cstrike/addons/podbot/podbot.cfg

FROM classic as melee

# add server config
COPY configs/melee/server.cfg /home/steam/cstrike/cstrike/server.cfg
COPY configs/melee/maps.ini /home/steam/cstrike/cstrike/addons/amxmodx/configs/maps.ini
COPY configs/melee/podbot.cfg /home/steam/cstrike/cstrike/addons/podbot/podbot.cfg
