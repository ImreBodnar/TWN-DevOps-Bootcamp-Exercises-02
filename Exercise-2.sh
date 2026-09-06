#!/bin/bash

# Update the package list
sudo apt update

# Install Java 25
sudo apt install openjdk-25-jre-headless

echo -e "\n"

# Check whether Java is installed
java -version 2>&1 | awk '/openjdk/ {count++} END {
if (count == 0)
    print "Java is NOT installed!"
else
    print "Java IS installed!"
}'

# Check whether Java is below or above version 11
java -version 2>&1 | awk -v OLD_JAVA_VERSION=11 '/openjdk/ {
if (substr($3,2,2) < OLD_JAVA_VERSION)
    printf "Java is older then version %d!", OLD_JAVA_VERSION
else
    printf "Java is at least version %d or higher!", OLD_JAVA_VERSION
}'

echo -e "\n"