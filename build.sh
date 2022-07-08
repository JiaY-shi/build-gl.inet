#!/bin/bash


CRTDIR=$(pwd)

base=$1
profile=$2
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

if [ ! -n "$profile" ]; then
	profile=target_wlan_ap-gl-ax1800
fi

echo "Start..."

#clone source tree 
git clone https://github.com/gl-inet/gl-infra-builder.git $base/gl-infra-builder
cp -r custom/  $base/gl-infra-builder/feeds/custom/
cp -r *.yml $base/gl-infra-builder/profiles
cd $base/gl-infra-builder
#setup

if [[ $profile == *5-4* ]]; then
        python3 setup.py -c config-wlan-ap-5.4.yml
else
        python3 setup.py -c config-wlan-ap.yml
fi

python3 setup.py -c config-wlan-ap-5.4.yml

cd wlan-ap/openwrt
./scripts/gen_config.py $profile glinet_depends custom

git clone https://github.com/gl-inet/glinet4.x.git $base/glinet
./scripts/feeds update -a 
./scripts/feeds install -a
make defconfig


make -j$(expr $(nproc) + 1) GL_PKGDIR=$base/glinet/ipq60xx/ V=s

