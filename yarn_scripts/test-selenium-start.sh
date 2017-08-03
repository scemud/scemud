#!/bin/bash

HERE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
NOHUP="$HERE/test-selenium.nohup"

if [ "$(yarn test-selenium-status)" = "running" ]; then
    exit 0
fi

printf "%s" "validating selenium-standalone server install"
nohup selenium-standalone install &> "$NOHUP" &
while true; do
    SUCCESS="selenium-standalone installation finished"
    LAST_LOG=$(cat $NOHUP | tail -2 | head -1)
    if [[ "$LAST_LOG" == "$SUCCESS"* ]]; then
        printf "%s\n" "done!"
        break
    fi
    printf "%s" "."
    sleep 1
done

printf "%s" "starting selenium-standalone server"
nohup selenium-standalone start &> "$NOHUP" &
while true; do
    SUCCESS="Selenium started"
    LAST_LOG=$(cat $NOHUP | tail -1)
    if [[ "$LAST_LOG" == "$SUCCESS"* ]]; then
        printf "%s\n" "done!"
        break
    fi
    printf "%s" "."
    sleep 1
done