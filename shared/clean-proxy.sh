#!/bin/sh

# be VERY CAREFUL...silently deletes...the `rm -rf *` version of decK
docker run --network host --rm kong/deck reset --force --headers kong-admin-token:KingKong
