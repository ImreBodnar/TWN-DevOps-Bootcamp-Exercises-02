# Storing the username in an environment variable
export TESTNAME=imre-bodnar

echo "Please type 'mem' or 'cpu' to sort the process list!"
read sortType
echo "Selected sorting is: $sortType"

# Determining the sorting type
if [[ $sortType == 'mem' ]]
then
    sorting="-%mem"
elif [[ $sortType == 'cpu' ]]
then
    sorting="-%cpu"
else
    echo "Unknown input!"
    sorting=""
fi

# Listing all the processes of the given user
if [[ $sorting == "" ]]
then
    ps -U $TESTNAME -u $TESTNAME u --sort=$sorting
fi