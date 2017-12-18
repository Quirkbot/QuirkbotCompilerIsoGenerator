SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
cd $SCRIPTPATH

sudo apt-get -qq update
sudo apt-get --yes --force-yes install xorriso
sudo apt-get --yes --force-yes install realpath
sudo apt-get --yes --force-yes install tree
sudo apt-get --yes --force-yes install curl
sudo apt-get --yes --force-yes install strace

curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.0/install.sh | bash
export NVM_DIR="/root/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

nvm install 9.2.0
npm --version
nvm --version
npm install

npm install quirkbot-arduino-builder@0.0.5
npm install quirkbot-arduino-hardware@0.4.9
npm install quirkbot-arduino-library@2.5.7
npm install quirkbot-avr-gcc@1.0.1

bash setup_compiler.sh
bash custom-tinycore.sh
