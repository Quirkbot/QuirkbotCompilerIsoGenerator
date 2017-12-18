#!/bin/sh
echo "ready"

sudo su
while true
do
	read IN < /dev/ttyS0
	if [ ! -z "$IN" ]
	then
		echo "go!"
		echo $IN > /compiler/build/sketch/firmware.ino.cpp
		sed -i.bak s/--nl--/\\n/g /compiler/build/sketch/firmware.ino.cpp
		sh /compiler/build.sh
		echo "--hex--" > /dev/ttyS0
		cat /compiler/build/firmware.ino.hex > /dev/ttyS0
		echo "--out--" > /dev/ttyS0
		#cat compileoutput > /dev/ttyS0
		#cat sizeoutput > /dev/ttyS0
		echo "--end--" > /dev/ttyS0
	fi
done
