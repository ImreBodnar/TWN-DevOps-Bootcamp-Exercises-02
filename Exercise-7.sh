#!/bin/bash

./Exercise-6.sh

isRunning=false
# Checking whether the app is running or stopped
if pgrep -x "node" > /dev/null
then
    echo "The NodeJS app is RUNNING!"
    isRunning=true
else
    echo "The NodeJS app is STOPPED!"
fi

if [[ isRunning ]]
then
    # Showing the running process of the app
    echo -e "\nThe running app process:"
    ps aux | grep "node server.js" | head -n 1

    # Showing the listening port of the app
    echo -e "\nThe running app is listening on port: "
    ss -tnlp | grep node | awk '{print substr($4,3,4)}'
fi