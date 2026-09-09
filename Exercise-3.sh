#!/bin/bash

# Storing the username in an environment variable
export TESTNAME="imre"

# Listing all the processes of the given user
ps -U $TESTNAME -u $TESTNAME u