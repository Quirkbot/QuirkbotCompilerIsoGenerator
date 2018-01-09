tce-load -wi git strace perl5 curl gcc make compiletc bash node tree

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
cd $SCRIPTPATH

# install xorriso
if hash xorriso 2>/dev/null; then
	echo "xorriso installed"
else
	XORRISO_VERSION="xorriso-1.4.8"
	wget https://www.gnu.org/software/xorriso/$XORRISO_VERSION.tar.gz
	tar xvzf $XORRISO_VERSION.tar.gz
	cd $XORRISO_VERSION
	./configure --prefix=/usr
	make
	sudo make install
	cd ..
fi

# npm install
npm install \
quirkbot-arduino-builder@0.0.5 \
quirkbot-arduino-hardware@0.4.9 \
quirkbot-arduino-library@2.5.7 \
quirkbot-avr-gcc@1.0.1
