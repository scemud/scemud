#!/bin/bash

HERE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

PID=$(ps aux | grep "\-\-port 3001" | awk '{print $2}')
if [ "$PID" != "" ]; then
    echo "running"
else
    echo "stopped"
fi
