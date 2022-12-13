# Docker image for Counter Strike 1.6 Dedicated Server

## Start the server

### Minimum properties setup

```bash
docker run -d -p 27015:27015/udp -p 27015:27015 -p 80:80 --name cs tractr/counter-strike-1.6-servers:deathmatch-team
```

### All properties setup

```bash
docker run -d \
  -p 27015:27015/udp \
  -p 27015:27015 \
  -p 80:80 \
  -e DOWNLOAD_URL="http://192.168.0.100:27015/cstrike/" \
  -e MAXPLAYERS=32 \
  -e BOTS_FILL=6 \
  -e MAP=de_dust2 \
  -e SERVER_NAME="My Server Name" \
  --name cs \
  tractr/counter-strike-1.6-servers:latest
```

#### Propetries

| Name           | Description                               | Default Value               |
|----------------|-------------------------------------------|-----------------------------|
| `PORT`         | The gaming port                           | `27015`                     |
| `SV_LAN`       | Restrict to LAN                           | `0`                         |
| `DOWNLOAD_URL` | URL where maps and assets are available   | `http://127.0.0.1/cstrike/` |
| `MAXPLAYERS`   | The maximum number of players             | `16`                        |
| `BOTS_FILL`    | Add bots to reach a min number of players | `0`                         |
| `MAP`          | The initial map                           | `de_dust2`                  |
| `SERVER_NAME`  | The server name                           | `Counter-Strike 1.6 Server` |

## Build the image

```bash
docker build . --tag tractr/counter-strike-1.6-servers:latest --target classic
```

```bash
docker build . --tag tractr/counter-strike-1.6-servers:melee --target melee
```

### Build and push all images

```bash
docker build . --tag tractr/counter-strike-1.6-servers:latest --target classic && \
docker push tractr/counter-strike-1.6-servers:latest && \
docker build . --tag tractr/counter-strike-1.6-servers:classic --target classic && \
docker push tractr/counter-strike-1.6-servers:classic && \
docker build . --tag tractr/counter-strike-1.6-servers:melee --target melee && \
docker push tractr/counter-strike-1.6-servers:melee && \
docker build . --tag tractr/counter-strike-1.6-servers:deathmatch-team --target deathmatch-team && \
docker push tractr/counter-strike-1.6-servers:deathmatch-team && \
docker build . --tag tractr/counter-strike-1.6-servers:deathmatch-ffa --target deathmatch-ffa && \
docker push tractr/counter-strike-1.6-servers:deathmatch-ffa
```

# Attributions

This project is based on:

- https://github.com/CajuCLC/cstrike-docker
- https://github.com/jimtouz/counter-strike-docker
- https://github.com/archont94/counter-strike1.6
- https://github.com/vitordino/counter-strike-docker

## Changes from original project

* Add ability to download maps and assets
* Added new maps.
* Added new parameters in run script.
