#!/bin/bash

echo -e "\nUPDATING PACKAGE LIST..."
sudo apt update

echo -e "\nINSTALLING NODE & NPM..."
sudo apt install nodejs npm -y

echo -e "\nNode.JS version:"
node --version
echo -e "\nNPM version:"
npm --version

read -p "Please enter a log directory: " log_directory
mkdir -p $log_directory

full_log_dir=$(pwd)/$log_directory
echo "LOG DIR FULL PATH: $full_log_dir"

export LOG_DIR=$full_log_dir
export APP_ENV=dev
export DB_USER=myuser
export DB_PWD=mysecret

echo -e "\nDOWNLOADING & UNZIPPING ARTIFACT..."
wget https://node-envvars-artifact.s3.eu-west-2.amazonaws.com/bootcamp-node-envvars-project-1.0.0.tgz
tar -xvzf bootcamp-node-envvars-project-1.0.0.tgz

cd package

echo -e "\nINSTALLING PACKAGES..."
npm install

echo -e "\nSTARTING APP..."
node server.js >> $full_log_dir/app.log 2>&1 &

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