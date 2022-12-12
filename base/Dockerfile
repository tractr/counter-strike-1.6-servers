# Source Dockerfile : https://github.com/jimtouz/counter-strike-docker/blob/master/Dockerfile
FROM cs16ds/server:add_bot_support as base


# add default server config
#COPY server.cfg /opt/hlds/cstrike/server.cfg

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
WORKDIR /opt/hlds
ENTRYPOINT service nginx start; /bin/entrypoint.sh
