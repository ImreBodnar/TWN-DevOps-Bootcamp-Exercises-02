#!/bin/bash

echo -e "\nUPDATING PACKAGE LIST..."
#sudo apt update

echo -e "\nINSTALLING NODE & NPM..."
#sudo apt install nodejs npm -y

echo -e "\nNode version is: $(node --version)"
echo -e "\nNPM version is: $(npm --version)"

# Create a new user for running the app
NEW_APP_USER_NAME=myapp
echo -e "\nCREATING A NEW USER..."
# sudo useradd -m $NEW_APP_USER_NAME

read -p "Please enter a log directory: " log_directory
full_log_dir=$(pwd)/$log_directory
if [[ -d $full_log_dir ]]
then
    echo "LOG DIRECTORY ALREADY EXISTS!"
else
    mkdir $full_log_dir
    echo "LOG DIRECTORY IS CREATED!"
fi

echo "LOG DIR FULL PATH: $full_log_dir"

sudo chown $NEW_APP_USER_NAME $full_log_dir -R

echo -e "\nDOWNLOADING & UNZIPPING ARTIFACT..."
wget https://node-envvars-artifact.s3.eu-west-2.amazonaws.com/bootcamp-node-envvars-project-1.0.0.tgz
tar xvzf ./bootcamp-node-envvars-project-1.0.0.tgz

sudo chown $NEW_APP_USER_NAME package -R

echo -e "\nINSTALLING PACKAGES..."
sudo -u $NEW_APP_USER_NAME bash -c "cd package &&
npm install"

echo -e "\nSTARTING APP..."
sudo -u $NEW_APP_USER_NAME bash -c "export LOG_DIR=$full_log_dir &&
export APP_ENV=dev &&
export DB_USER=myuser &&
export DB_PWD=mysecret &&
node server.js &"

isRunning=false
# Checking whether the app is running or stopped
if pgrep -x "node" #> /dev/null
then
    echo "The NodeJS app is RUNNING!"
    isRunning=true
else
    echo "The NodeJS app is STOPPED!"
fi

if [[ $isRunning == true ]]
then
    # Showing the running process of the app
    echo -e "\nThe running app process:"
    ps aux | grep "node server.js" | grep -v grep

    # Showing the listening port of the app
    echo -e "\nThe running app is listening on port: "
    ss -tnlp | grep node | awk '{print substr($4,3,4)}'
fi