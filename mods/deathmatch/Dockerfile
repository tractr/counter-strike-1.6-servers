FROM archont94/counter-strike1.6:latest

# Install helpers
RUN apt-get update && \
    apt-get install -y unzip

# Add mod
COPY mod/csdm-2.1.zip /csdm-2.1.zip
RUN unzip -o /csdm-2.1.zip -d /hlds/cstrike

# Add mod config
COPY mod/config /hlds/cstrike/addons/amxmodx/configs

# Ad global config
COPY config/* /hlds/cstrike
