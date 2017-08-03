#!/bin/bash

HERE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
NOHUP="$HERE/dev-server.nohup"

if [ "$(yarn dev-server-status)" = "running" ]; then
    exit 0
fi

printf "%s" "starting dev server"
nohup webpack-dev-server \
    -d \
    --history-api-fallback \
    --hot \
    --inline \
    --progress \
    --colors \
    --port 3000 \
    &> "$NOHUP" &

while true; do
    SUCCESS="webpack: Compiled successfully."
    FAILURE="webpack: Failed to compile."
    LAST_LOG=$(cat $NOHUP | tail -1)
    if [[ "$LAST_LOG" == "$SUCCESS"* ]]; then
        printf "%s\n" "done!"
        break
    fi
    if [[ "$LAST_LOG" == "$FAILURE"* ]]; then
        printf "%s\n" "error!"
        tail $NOHUP
        break
    fi
    printf "%s" "."
    sleep 1
done