#!/bin/bash


if [ -z $IDF_PATH ];
then
	echo "ERROR: IDF_PATH variable not set"
	exit
fi

echo "Patching ESP-IDF makefiles"
patch_path=$(pwd)/helpers/makefile.patch
cd $IDF_PATH
git apply  $patch_path


echo "Installing ponyc.sh"
compiler_path=$(pwd)/helpers/ponyc.sh
install $compiler_path /usr/local/bin/ponyc.sh
