# Docker image for Counter Strike 1.6 Dedicated Server

## Start the server

### Minimum properties setup

```bash
docker run -d \
  -p 26900:26900/udp \
  -p 27020:27020/udp \
  -p 27015:27015/udp \
  -p 27015:27015 \
  -p 80:80 \
  -e ADMIN_STEAM=0:1:1234566 \
  --name cs \
  tractr/counter-strike-1.6-servers:latest
```

### All properties setup
```bash
docker run -d \
  -p 26900:26900/udp \
  -p 27020:27020/udp \
  -p 27015:27015/udp \
  -p 27015:27015 \
  -p 80:80 \
  -e DOWNLOAD_URL="http://192.168.0.100:27015/cstrike/" \
  -e MAXPLAYERS=32 \
  -e START_MAP=de_dust2 \
  -e SERVER_NAME="My Server Name" \
  -e START_MONEY=16000 \
  -e BUY_TIME=0.25 \
  -e FRIENDLY_FIRE=1 \
  -e ADMIN_STEAM=0:1:1234566 \
  --name cs \
  tractr/counter-strike-1.6-servers:latest +log
```

#### Propetries

| Name | Description                                             | Default Value |
| --- |---------------------------------------------------------| --- |
| `DOWNLOAD_URL` | URL where maps and assets are available                 | `http://127.0.0.1/cstrike/` |
| `MAXPLAYERS` | The maximum number of players                           | `32` |
| `START_MAP` | The initial map                                         | `de_dust2` |
| `SERVER_NAME` | The server name                                         | `Counter-Strike 1.6 Server` |
| `START_MONEY` | The initial money                                       | `800` |
| `BUY_TIME` | The allowed time to buy items in each round (*minutes*) | `0.25` |
| `FRIENDLY_FIRE` | Enable or disable the friendly fire. (*off: 0, on: 1*)  | `1` |
| `SERVER_PASSWORD` | The server password. (*Empty for no server password*)   | None |
| `RCON_PASSWORD` | The rcon password. (*Empty for no rcon password*)       | None |
| `RESTART_ON_FAIL` | *TBD*                                                   | *TBD* |
| `ADMIN_STEAM` | *TBD - amx mod related*                                 | *TBD* |

## Build the image

```bash
docker build . --tag tractr/counter-strike-1.6-servers:latest --target classic
```

```bash
docker build . --tag tractr/counter-strike-1.6-servers:melee --target melee
```

# Attributions

This project is based on:

- https://github.com/jimtouz/counter-strike-docker
- https://github.com/archont94/counter-strike1.6

## Changes from original project

* Add ability to download maps and assets
* Added new maps.
* Added new parameters in run script.
