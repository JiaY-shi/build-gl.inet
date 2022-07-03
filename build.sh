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
#cp -r custom.yml $base/gl-infra-builder/profiles
cp -r glinet-ax1800.yml $base/gl-infra-builder/profiles
cd $base/gl-infra-builder

#setup
python3 setup.py -c config-wlan-ap-5.4.yml

#rm -f $base/gl-infra-builder/patches-wlan-ap/openwrt/0006-kmod-wireguard-replaced-by-gl-feeds.patch

#openwrt git
#sed -i 's/378769b5551714ccaa821b481bfeecbf362f351e/f0f9b7ac5c067102136885a58bca867adffa488c/g' $base/gl-infra-builder/wlan-ap/config.yml
#sed -i 's/c67509efd7d0c43eb3f622f06c8a31aa28d22f6e/f0f9b7ac5c067102136885a58bca867adffa488c/g' $base/gl-infra-builder/wlan-ap/config.yml
#luci git
sed -i 's/1c3b32dc1bec15e3076a447762b1c4f94eb75fb7/fe09ab990256d8b63e76cc1ab2435baef921b8b4/g' $base/gl-infra-builder/profiles/target_wlan_ap-gl-ax1800-common-5-4.yml

cd wlan-ap/openwrt
./scripts/gen_config.py glinet-ax1800 

./scripts/feeds update -a 
./scripts/feeds install -a
make defconfig
