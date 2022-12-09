# Deathmatch

https://forums.alliedmods.net/showthread.php?t=45825

## Build commands

### Team Deathmatch

```bash
docker build . --target deathmatch-team --tag tractr/counter-strike-1.6-servers:deathmatch-team
```

```bash
docker push tractr/counter-strike-1.6-servers:deathmatch-team
```

### FFA Deathmatch

```bash
docker build . --target deathmatch-ffa --tag tractr/counter-strike-1.6-servers:deathmatch-ffa
```

```bash
docker push tractr/counter-strike-1.6-servers:deathmatch-ffa
```
