# Storing the username in an environment variable
export TESTNAME="imre"

echo "Please type 'mem' or 'cpu' to sort the process list!"
read sortType
echo "Selected sorting is: $sortType"

# Listing all the processes of the given user
if [[ $sortType == 'mem' ]]
then
    ps -U $TESTNAME -u $TESTNAME u --sort=-%mem
elif [[ $sortType == 'cpu' ]]
then
    ps -U $TESTNAME -u $TESTNAME u --sort=-%cpu
else
    echo "Unknown input!"
fi