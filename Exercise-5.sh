#!/bin/bash

# Storing the username in an environment variable
export TESTNAME="imre"

# Read and store user input
read -p "Please type 'mem' or 'cpu' to sort the process list! " sortType
read -p "Please type the number of rows! " rowNumber

# Increment rowNumber because of header row
((rowNumber++))

# Listing all the processes of the given user
if [[ $sortType == 'mem' ]]
then
    ps -U $TESTNAME -u $TESTNAME u --sort=-%mem | head -n $rowNumber
elif [[ $sortType == 'cpu' ]]
then
    ps -U $TESTNAME -u $TESTNAME u --sort=-%cpu | head -n $rowNumber
else
    echo "Unknown input!"
fi