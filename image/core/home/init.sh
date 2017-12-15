cd "compiler"
while true
do
	read IN < /dev/ttyS0
	if [ ! -z "$IN" ]
	then
		echo $IN > "build/sketch/firmware.ino.cpp"
		sed -i.bak s/--nl--/\\n/g "build/sketch/firmware.ino.cpp"
		sh "build.sh"
		echo "--hex--" > /dev/ttyS0
		cat "build/firmware.ino.hex" > /dev/ttyS0
		echo "--out--" > /dev/ttyS0
		#cat compileoutput > /dev/ttyS0
		#cat sizeoutput > /dev/ttyS0
		echo "--end--" > /dev/ttyS0
	fi
