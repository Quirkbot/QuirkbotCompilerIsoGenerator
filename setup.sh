sudo apt-get -qq update
sudo apt-get --yes --force-yes install xorriso
sudo apt-get --yes --force-yes install realpath
sudo apt-get --yes --force-yes install tree
curl -sL https://deb.nodesource.com/setup_9.x | sudo -E bash -
sudo apt-get install -y nodejs

npm install

bash setup_compiler.sh
bash custom-tinycore.sh
