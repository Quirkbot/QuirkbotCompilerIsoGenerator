# store the root dir
ROOT=$(pwd)

# create the base dir
echo "#########################################################################"
echo "creating base dir"
rm -rf "$ROOT/compiler"
mkdir "$ROOT/compiler"
cd "$ROOT/compiler"
BASE=$(pwd)

# install dependencies
echo "#########################################################################"
echo "installing dependencies"
#tce-load -wi node strace perl5 curl
#npm install
mv "$ROOT/node_modules" "$BASE/node_modules"

# create temp dir and setup files
echo "#########################################################################"
echo "creating directories"
mkdir "$BASE/build"
mkdir "$BASE/firmware"

# create the base firmware
echo "#########################################################################"
echo "creating base firmware"
echo '#include "Quirkbot.h"
void setup(){}
void loop(){}' >> "$BASE/firmware/firmware.ino"

# do a first build and capture the output, so we can extract some info from it
echo "#########################################################################"
echo "doing first build"
"$BASE/node_modules/quirkbot-arduino-builder/tools/arduino-builder" \
-hardware="$BASE/node_modules" \
-hardware="$BASE/node_modules/quirkbot-arduino-builder/tools/hardware" \
-libraries="$BASE/node_modules" \
-tools="$BASE/node_modules/quirkbot-avr-gcc/tools" \
-tools="$BASE/node_modules/quirkbot-arduino-builder/tools/tools" \
-build-path="$BASE/build" \
-fqbn="quirkbot-arduino-hardware:avr:quirkbot" \
-core-api-version="10805" \
-verbose \
"$BASE/firmware/firmware.ino" \
>> "$BASE/output.txt"

# capture the compilation part
cat "$BASE/output.txt"| grep "firmware.ino.cpp.o" | head -n 1 >> "$BASE/build.sh"

# capture the "link and copy" part
cat "$BASE/output.txt"| grep "firmware.ino.elf" | grep -v "firmware.ino.eep" >> "$BASE/build.sh"

cat "$BASE/build.sh"


# tracefile all the used files
echo "#########################################################################"
echo "discovering all used files"
perl "$ROOT/tracefile.perl" -uef sh "$BASE/build.sh" | grep $BASE >> "$BASE/rawtrace"
cat "$BASE/rawtrace" | xargs -n1 realpath >> "$BASE/trace"
cat "$BASE/trace"

# do test build
echo "#########################################################################"
echo "doing test build"
time sh "$BASE/build.sh"
ls "$BASE/build"

# delete all unused filesf
echo "#########################################################################"
echo "deleting unused files"
find "$BASE" -type f | grep -vFf "$BASE/trace" >> "$BASE/remove.txt"
xargs rm -rf < "$BASE/remove.txt"
find "$BASE" -type d -empty -delete
rm -rf "$BASE/build/firmware.ino.elf"
rm -rf "$BASE/build/firmware.ino.hex"
tree $BASE

# update the home path to the location within the new image
# echo "#########################################################################"
# echo "updating home path"
# grep -rl "$ROOT" "$BASE"/ | xargs sed -i "s|$ROOT||g"
# cat "$BASE/build.sh"

# compress the compiler
#tar -zcvf "$BASE/../compiler.tar.gz" "$BASE"

# move into rootfs so we can prepare it for the image
rm -rf "$ROOT/rootfs$ROOT"
mkdir -p "$ROOT/rootfs$ROOT"
mv -p "$BASE" "$ROOT/rootfs$ROOT/"
chmod -R 777 "$ROOT/rootfs"

# restore dir
cd "$ROOT"
