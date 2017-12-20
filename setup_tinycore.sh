SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
cd $SCRIPTPATH

#sh setup_tinycore_dependencies.sh
bash setup_compiler.sh
sudo bash setup_image.sh
curl --upload-file build/quirkbot.iso https://transfer.sh/quirkbot.iso
