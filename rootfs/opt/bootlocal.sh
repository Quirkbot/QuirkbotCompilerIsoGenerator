#!/bin/sh
echo "ready"
sudo su
while true
do
	read IN < /dev/ttyS0
	if [ ! -z "$IN" ]
	then
		echo "go!"
		echo $IN > /home/tc/repo/compiler/build/sketch/firmware.ino.cpp
		sed -i s/--nl--/\\n/g /home/tc/repo/compiler/build/sketch/firmware.ino.cpp
		sh /home/tc/repo/compiler/build.sh
		echo "--hex--" > /dev/ttyS0
		cat /home/tc/repo/compiler/build/firmware.ino.hex > /dev/ttyS0
		echo "--out--" > /dev/ttyS0
		#cat compileoutput > /dev/ttyS0
		#cat sizeoutput > /dev/ttyS0
		echo "--end--" > /dev/ttyS0
	fi
done
