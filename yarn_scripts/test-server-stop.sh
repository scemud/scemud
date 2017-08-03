#!/bin/bash

HERE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

NOHUP="$HERE/test-server.nohup"
echo "" > "$NOHUP"

PID=$(ps aux | grep "\-\-port 3001" | awk '{print $2}')
if [ "$PID" != "" ]; then
    kill $PID
fi