SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
cd $SCRIPTPATH

#bash setup_mac_dependencies.sh
bash setup_mac_compiler.sh
bash setup_mac_image.sh
