# Source Dockerfile: https://github.com/CajuCLC/cstrike-docker/blob/main/Dockerfile
# Source branch: https://github.com/CajuCLC/cstrike-docker
FROM cajuclc/cstrike-docker:latest as classic

# Need privilege
USER root

# install dependencies
RUN apt-get update && \
    apt-get install -y nginx

# configure nginx to allow for FastDownload
RUN mv /etc/nginx/sites-available/default /etc/nginx/sites-available/default.backup && \
    bash -c "mkdir -p /srv/cstrike/{gfx,maps,models,overviews,sound,sprites}/nothing-here"
COPY --chown=steam:steam nginx.conf /etc/nginx/sites-available/default

# add entrypoint
COPY --chown=steam:steam entrypoint.sh /bin/entrypoint.sh
RUN chmod +x /bin/entrypoint.sh
ENTRYPOINT ["/bin/entrypoint.sh"]

# Remove map.ini in order to use mapcycle.txt
RUN rm /home/steam/cstrike/cstrike/addons/amxmodx/configs/maps.ini

# Remove message of the day
RUN rm /home/steam/cstrike/cstrike/motd.txt

# add server config
COPY --chown=steam:steam configs/classic/server.cfg /home/steam/cstrike/cstrike/server.cfg
COPY --chown=steam:steam configs/classic/mapcycle.txt /home/steam/cstrike/cstrike/mapcycle.txt
COPY --chown=steam:steam configs/classic/podbot.cfg /home/steam/cstrike/cstrike/addons/podbot/podbot.cfg

FROM classic as melee

# add server config
COPY --chown=steam:steam configs/melee/server.cfg /home/steam/cstrike/cstrike/server.cfg
COPY --chown=steam:steam configs/melee/mapcycle.txt /home/steam/cstrike/cstrike/mapcycle.txt

FROM classic as hsonly

# Install HeadShot Only AMX Plugin
COPY --chown=steam:steam configs/hsonly/mod/hsonly.sma /home/steam/cstrike/cstrike/addons/amxmodx/scripting/hsonly.sma
COPY --chown=steam:steam configs/hsonly/mod/hsonly.amxx /home/steam/cstrike/cstrike/addons/amxmodx/plugins/hsonly.amxx
COPY --chown=steam:steam configs/hsonly/mod/hs_only.txt /home/steam/cstrike/cstrike/addons/amxmodx/data/lang/hs_only.txt
COPY --chown=steam:steam configs/hsonly/server.cfg /home/steam/cstrike/cstrike/server.cfg
RUN echo "hsonly.amxx               ; HeadShot Only" >> "/home/steam/cstrike/cstrike/addons/amxmodx/configs/plugins.ini"

FROM classic as deathmatch-team

RUN apt-get update && \
    apt-get install -y unzip curl

# Install CSDM
RUN curl -sqL 'https://www.bailopan.net/csdm/files/csdm-2.1.2.zip' -o '/home/steam/csdm.zip' && \
    unzip -u '/home/steam/csdm.zip' -d /home/steam/cstrike/cstrike/ && rm -f '/home/steam/csdm.zip'

# Patch CSDM https://forums.alliedmods.net/showpost.php?p=1909682&postcount=27?p=1909682&postcount=27
RUN curl -sqL 'https://forums.alliedmods.net/attachment.php?attachmentid=116910&d=1362864766' -o '/home/steam/patch.zip' && \
    unzip -jfo '/home/steam/patch.zip' -d /home/steam/cstrike/cstrike/addons/amxmodx/modules && rm -f '/home/steam/patch.zip'

RUN apt-get remove -y unzip curl

# add server config
COPY --chown=steam:steam configs/deathmatch-team/server.cfg /home/steam/cstrike/cstrike/server.cfg
COPY --chown=steam:steam configs/deathmatch-team/mapcycle.txt /home/steam/cstrike/cstrike/mapcycle.txt
COPY --chown=steam:steam configs/deathmatch-team/csdm.cfg /home/steam/cstrike/cstrike/addons/amxmodx/configs/csdm.cfg

FROM deathmatch-team as deathmatch-ffa

# add server config
COPY --chown=steam:steam configs/deathmatch-ffa/csdm.cfg /home/steam/cstrike/cstrike/addons/amxmodx/configs/csdm.cfg
COPY --chown=steam:steam configs/deathmatch-ffa/podbot.cfg /home/steam/cstrike/cstrike/addons/podbot/podbot.cfg
