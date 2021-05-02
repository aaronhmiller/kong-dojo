#!/bin/sh

if [ -z "$1" ]; then
  echo "What is the relative location and name of your dump file?"
  read NAME
else
  NAME=$1
fi

# pipe the contents, run deck interactively and sync via stdin
cat $NAME | docker run -i --network host --rm kong/deck sync -s - --headers kong-admin-token:KingKong
