SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
cd $SCRIPTPATH

bash setup_linux_dependencies.sh
bash setup_linux_compiler.sh
bash setup_linux_image.sh
