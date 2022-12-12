# Source Dockerfile : https://github.com/jimtouz/counter-strike-docker/blob/master/Dockerfile
FROM cs16ds/server:add_bot_support as classic

# add default server config
COPY configs/classic/server.cfg /opt/hlds/cstrike/server.cfg
COPY configs/classic/maps.ini /opt/hlds/cstrike/addons/amxmodx/configs/maps.ini

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

# add default server config
COPY configs/melee/server.cfg /opt/hlds/cstrike/server.cfg
COPY configs/melee/maps.ini /opt/hlds/cstrike/addons/amxmodx/configs/maps.ini
