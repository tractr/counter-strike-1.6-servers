# Source Dockerfile: https://github.com/jimtouz/counter-strike-docker/blob/add_bot_support/Dockerfile
# Source branch: https://github.com/jimtouz/counter-strike-docker/tree/add_bot_support
FROM cajuclc/cstrike-docker:latest as classic

# add server config
COPY configs/classic/server.cfg /home/cstrike/cstrike/server.cfg
COPY configs/classic/maps.ini /home/cstrike/cstrike/addons/amxmodx/configs/maps.ini
COPY configs/classic/podbot.cfg /home/cstrike/cstrike/addons/podbot/podbot.cfg

# install dependencies
RUN apt-get update && \
    apt-get -y install nginx

# configure nginx to allow for FastDownload
RUN mv /etc/nginx/sites-available/default /etc/nginx/sites-available/default.backup && \
    bash -c "mkdir -p /srv/cstrike/{gfx,maps,models,overviews,sound,sprites}/nothing-here"
COPY nginx.conf /etc/nginx/sites-available/default

# add entrypoint
ADD entrypoint.sh /bin/entrypoint.sh
RUN chmod +x /bin/entrypoint.sh

# Startup
ENTRYPOINT ["/bin/entrypoint.sh"]

FROM classic as melee

# add server config
COPY configs/melee/server.cfg /home/cstrike/cstrike/server.cfg
COPY configs/melee/maps.ini /home/cstrike/cstrike/addons/amxmodx/configs/maps.ini
COPY configs/melee/podbot.cfg /home/cstrike/cstrike/addons/podbot/podbot.cfg
