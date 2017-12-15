# store the root dir
ROOT=$(pwd)

# create the base dir
echo "creating base dir"
rm -rf "$ROOT/compiler"
mkdir "$ROOT/compiler"
cd "$ROOT/compiler"
BASE=$(pwd)

# install dependencies
echo "installing dependencies"
#tce-load -wi node strace perl5 curl

#rm -rf "$BASE/node_modules"
npm install quirkbot-arduino-builder@0.0.5
npm install quirkbot-arduino-hardware@0.4.9
npm install quirkbot-arduino-library@2.5.7
npm install quirkbot-avr-gcc@1.0.1

# create temp dir and setup files
echo "creating directories"
mkdir "$BASE/build"
mkdir "$BASE/firmware"

# create the base firmware
echo "creating base firmware"
echo '#include "Quirkbot.h"
void setup(){}
void loop(){}' >> "$BASE/firmware/firmware.ino"

# do a first build and capture the output, so we can extract some info from it
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

# tracefile all the used files
perl "$ROOT/tracefile.perl" -uef sh "$BASE/build.sh" | grep $BASE >> "$BASE/rawtrace"
cat "$BASE/rawtrace" | xargs -n1 realpath
cat "$BASE/rawtrace" | xargs -n1 realpath >> "$BASE/trace"

# delete all unused filesf
find "$BASE" -type f | grep -vFf "$BASE/trace" >> "$BASE/remove.txt"
xargs rm -rf < "$BASE/remove.txt"
find "$BASE" -type d -empty -delete
rm -rf "$BASE/sketch/firmare.ino.cpp"
rm -rf "$BASE/sketch/firmare.ino.cpp.d"
rm -rf "$BASE/sketch/firmare.ino.cpp.o"
rm -rf "$BASE/build/firmware.ino.elf"
rm -rf "$BASE/build/firmware.ino.hex"

# compress the compiler
#tar -zcvf "$BASE/../compiler.tar.gz" "$BASE"

ls
# restore dir
cd "$ROOT"
