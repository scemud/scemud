#!/bin/bash

HERE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if ! [ -d "$HERE/../node_modules" ]; then
    yarn test-selenium-stop
    yarn test-server-stop
    
    yarn install
fi

yarn test-selenium-start
yarn test-server-restart

wdio "$HERE/../wdio.conf.js"

yarn test-server-stop