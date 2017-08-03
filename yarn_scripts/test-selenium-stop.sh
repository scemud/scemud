#!/bin/bash

HERE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

NOHUP="$HERE/test-selenium.nohup"
echo "" > "$NOHUP"

PID=$(ps aux | grep "[s]elenium-standalone start" | awk '{print $2}')
if [ "$PID" != "" ]; then
    kill $PID
fi