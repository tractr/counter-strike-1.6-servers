FROM archont94/counter-strike1.6:latest

RUN apt-get update && \
    apt-get install -y unzip

COPY mod/csdm-2.1.zip /csdm-2.1.zip
RUN unzip -o /csdm-2.1.zip -d /hlds/cstrike

COPY mod/config /hlds/cstrike/addons/amxmodx/configs

