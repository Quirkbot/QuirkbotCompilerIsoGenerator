# store the root dir
ROOT=$(pwd)

# enter the base dir
cd "$ROOT/image"
BASE=$(pwd)

# create temp dir
echo "#########################################################################"
echo "creating image temp dir"
TMP="$BASE/temp"
rm -rf "$TMP"
cp -R "$BASE/src" "$TMP"
cp -R "$BASE/core" "$TMP/boot/core"

# add compiler resources
echo "#########################################################################"
echo "adding compiler resources"
cp -R "$ROOT/compiler" "$TMP/boot/core/home/compiler"

# pack the core
echo "#########################################################################"
echo "packing the core"
find "$TMP/boot/core" | cpio -H newc -o | gzip > "$TMP/boot/core.gz"

# cleanup
echo "#########################################################################"
echo "final cleanup"
find "$TMP" -mindepth 1 -name '.*' -delete
rm -rf "$TMP/boot/core"

# build iso
echo "#########################################################################"
echo "building iso"
xorriso -as mkisofs -iso-level 3 -full-iso9660-filenames -volid ISOIMAGE \
        -eltorito-boot "$BASE/boot/isolinux/isolinux.bin" -boot-load-size 4 \
        -eltorito-catalog "$BASE/boot/isolinux/boot.cat" -boot-info-table \
        -no-emul-boot -output "$ROOT/image.iso" "$TMP"

# restore dir
cd "$ROOT"
