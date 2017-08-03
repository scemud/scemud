#!/bin/bash

HERE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

NOHUP="$HERE/dev-server.nohup"
echo "" > "$NOHUP"

PID=$(ps aux | grep "\-\-port 3000" | awk '{print $2}')
if [ "$PID" != "" ]; then
    kill $PID
fi