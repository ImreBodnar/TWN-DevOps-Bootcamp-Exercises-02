#!/bin/bash

echo -e "\nUPDATING PACKAGE LIST..."
sudo apt update

echo -e "\nINSTALLING NODE & NPM..."
sudo apt install nodejs npm -y

echo -e "\nNode version is: $(node --version)"
echo -e "\nNPM version is: $(npm --version)"

# Create a new user for running the app
NEW_APP_USER_NAME=myapp
echo -e "\nCREATING A NEW USER..."
sudo useradd -m $NEW_APP_USER_NAME

install_folder="/opt/nodeapp"
read -p "Please enter a log directory: " log_directory
full_log_dir=$install_folder/$log_directory
if [[ -d $full_log_dir ]]
then
    echo "LOG DIRECTORY ALREADY EXISTS!"
else
    sudo mkdir -p $full_log_dir
    echo "LOG DIRECTORY IS CREATED!"
fi

echo "LOG DIR FULL PATH: $full_log_dir"

sudo chown $NEW_APP_USER_NAME:$NEW_APP_USER_NAME $full_log_dir -R

cd $install_folder
sudo chown $NEW_APP_USER_NAME:$NEW_APP_USER_NAME $install_folder -R

echo -e "\nDOWNLOADING & UNZIPPING ARTIFACT..."
sudo wget https://node-envvars-artifact.s3.eu-west-2.amazonaws.com/bootcamp-node-envvars-project-1.0.0.tgz
sudo tar xvzf ./bootcamp-node-envvars-project-1.0.0.tgz

sudo chown $NEW_APP_USER_NAME:$NEW_APP_USER_NAME package -R

echo -e "\nINSTALLING PACKAGES..."
sudo -u $NEW_APP_USER_NAME bash -c "cd $install_folder/package &&
npm install"

echo -e "\nSTARTING APP..."
sudo -u $NEW_APP_USER_NAME bash -c "cd $install_folder/package && 
export LOG_DIR=$full_log_dir &&
export APP_ENV=dev &&
export DB_USER=myuser &&
export DB_PWD=mysecret &&
node server.js &"

isRunning=false
# Checking whether the app is running or stopped
if pgrep -x "node"
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
    ps aux | grep "node server.js" | grep -v grep | grep -v bash

    # Showing the listening port of the app
    sleep 2
    echo -e "\nThe running app is listening on port: "
    sudo ss -tnlp | grep node | awk '{print substr($4,3,4)}'
fi