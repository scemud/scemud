#!/bin/bash

HERE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

PID=$(ps aux | grep "[s]elenium-standalone start" | awk '{print $2}')
if [ "$PID" != "" ]; then
    echo "running"
else
    echo "stopped"
fi
