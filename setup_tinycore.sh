SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
cd $SCRIPTPATH

bash setup_tinycore_dependencies.sh
bash setup_compiler.sh
bash setup_image.sh
