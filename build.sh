#!/bin/bash


CRTDIR=$(pwd)

base=$1
echo $base
if [ ! -e "$base" ]; then
	echo "Please enter base folder"
	exit 1
else
	if [ ! -d $base ]; then 
		echo "Openwrt base folder not exist"
		exit 1
	fi
fi

echo "Start..."

#clone source tree 
git clone https://github.com/gl-inet/gl-infra-builder.git $base/gl-infra-builder
cp -r custom/  $base/gl-infra-builder/feeds/custom/
cp -r glinet-ax1800.yml $base/gl-infra-builder/profiles
cd $base/gl-infra-builder

#setup
python3 setup.py -c config-wlan-ap-5.4.yml


cd wlan-ap/openwrt
./scripts/gen_config.py glinet-ax1800 

./scripts/feeds update -a 
./scripts/feeds install -a
make defconfig
