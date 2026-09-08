echo -e "\nUPDATING PACKAGE LIST..."
sudo apt update

echo -e "\nINSTALLING NODE & NPM..."
sudo apt install nodejs npm -y

echo -e "\nNode.JS version:"
node --version
echo -e "\nNPM version:"
npm --version

echo -e "\nDOWNLOADING & UNZIPPING ARTIFACT..."
wget https://node-envvars-artifact.s3.eu-west-2.amazonaws.com/bootcamp-node-envvars-project-1.0.0.tgz
tar -xvzf bootcamp-node-envvars-project-1.0.0.tgz

export APP_ENV=dev
export DB_USER=myuser
export DB_PWD=mysecret

cd package

echo -e "\nINSTALLING PACKAGES..."
npm install

echo -e "\nSTARTING APP..."
node server.js > /dev/null 2>&1 &