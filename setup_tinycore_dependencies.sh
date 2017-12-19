tce-load -wi git strace perl5 curl gcc make compiletc bash node

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
cd $SCRIPTPATH

# install tree
TREE_VERSION="tree-1.7.0"
wget http://mama.indstate.edu/users/ice/tree/src/$TREE_VERSION.tgz
tar zxvf $TREE_VERSION.tgz
cd $TREE_VERSION
make
sudo make install
cd ..


# install xorriso
XORRISO_VERSION="xorriso-1.4.8"
wget https://www.gnu.org/software/xorriso/$XORRISO_VERSION.tar.gz
tar xvzf $XORRISO_VERSION.tar.gz
cd $XORRISO_VERSION
./configure --prefix=/usr
make
sudo make install
cd ..

# npm install
./$NODE_VERSION/bin/npm install \
quirkbot-arduino-builder@0.0.5 \
quirkbot-arduino-hardware@0.4.9 \
quirkbot-arduino-library@2.5.7 \
quirkbot-avr-gcc@1.0.1
