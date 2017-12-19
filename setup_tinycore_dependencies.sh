tce-load -wi git strace perl5 curl gcc make compiletc

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
cd $SCRIPTPATH

# install tree
$TREE_VERSION="tree-1.7.0"
wget http://mama.indstate.edu/users/ice/tree/src/$TREE_VERSION.tgz
tar zxvf $TREE_VERSION.tgz
cd $TREE_VERSION
make
sudo make install
cd ..

# install node
NODE_VERSION="node-v9.3.0-linux-x86"
wget https://nodejs.org/download/release/latest/$NODE_VERSION.tar.gz
tar xvzf $NODE_VERSION.tar.gz
export PATH=$PATH:$SCRIPTPATH/$NODE_VERSION/bin

# install xorriso
XORRISO_VERSION="xorriso-1.4.8"
wget https://www.gnu.org/software/xorriso/$XORRISO_VERSION.tar.gz -O xorriso.tar.gz
tar xvzf $XORRISO_VERSION
cd $XORRISO_VERSION
./configure --prefix=/usr
make
sudo make install
cd ..
