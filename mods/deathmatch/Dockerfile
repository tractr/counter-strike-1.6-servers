FROM archont94/counter-strike1.6:latest as base

# Install helpers
RUN apt-get update && \
    apt-get install -y unzip

# Add mod
COPY mod/csdm-2.1.zip /csdm-2.1.zip
RUN unzip -o /csdm-2.1.zip -d /hlds/cstrike

# Copy configs for team DM
FROM base as deathmatch-team
COPY config/team/mod/* /hlds/cstrike/addons/amxmodx/configs
COPY config/team/base/* /hlds/cstrike

# Copy configs for ffa DM
FROM base as deathmatch-ffa
COPY config/ffa/mod/* /hlds/cstrike/addons/amxmodx/configs
COPY config/ffa/base/* /hlds/cstrike
