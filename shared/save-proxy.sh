#!/bin/sh

# dump proxy's settings to stdout and redirect to local file...will overwrite so be mindful of that

if [ -z "$1" ]; then
  echo "What do you want to name the dump file?"
  read NAME
elif [ $1 == 'kong.yaml' ]; then
  echo "You must choose a name other than deck's default output filename."
  exit 1
else
  NAME=$1
fi
docker run --network host --rm kong/deck dump --headers kong-admin-token:KingKong -o - > ./$NAME.yaml
