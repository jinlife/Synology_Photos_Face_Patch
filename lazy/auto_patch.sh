#!/bin/sh

# DS920+
dsmodel=$1
# 42661
os_version=$2
# 1.2.0-0263
photo_version=$3

# download old pat for syno_extract_system_patch # thanks for jumkey's idea.
mkdir synoesp
curl --location https://global.download.synology.com/download/DSM/release/7.0.1/42218/DSM_DS3622xs%2B_42218.pat --output oldpat.tar.gz
tar -C ./synoesp/ -xf oldpat.tar.gz rd.gz
cd synoesp

output=$(xz -dc < rd.gz 2>/dev/null | cpio -idm 2>&1)
mkdir extract && cd extract
cp -v ../usr/lib/libcurl.so.4 ../usr/lib/libmbedcrypto.so.5 ../usr/lib/libmbedtls.so.13 ../usr/lib/libmbedx509.so.1 ../usr/lib/libmsgpackc.so.2 ../usr/lib/libsodium.so ../usr/lib/libsynocodesign-ng-virtual-junior-wins.so.7 ../usr/syno/bin/scemd ./
ln -s scemd syno_extract_system_patch

# Extract pat file
pat_address="https://global.download.synology.com/download/DSM/release/7.1/"${os_version}"-1/DSM_"${dsmodel}"_"${os_version}".pat"
echo ${pat_address}
#https://global.download.synology.com/download/DSM/release/7.1/42661/DSM_DS920+_42661.pat
#https://cndl.synology.cn/download/DSM/release/7.1/42661-1/DSM_DS920%2B_42661.pat
curl --location  ${pat_address} --output ${os_version}.pat

sudo LD_LIBRARY_PATH=. ./syno_extract_system_patch ${os_version}.pat output-pat

cd output-pat
#ls
#echo "start to pack again"
#sudo tar -zcvf ${os_version}.pat * && sudo chmod 777 ${os_version}.pat
echo "Start to patch libsynosdk.so.7"
mkdir hda1Extract
tar -C hda1Extract -xf hda1.tgz
echo "hda1 in"
#ls
echo "cp file libsynosdk.so.7"
cp -v ./hda1Extract/usr/lib/libsynosdk.so.7 ../../../
cp -v ./hda1Extract/usr/syno/sbin/synoarchive ./
ln -s synoarchive syno_extract_spk

echo "Start patch Photos"
photo_address="https://global.download.synology.com/download/Package/spk/SynologyPhotos/${photo_version}/SynologyPhotos-x86_64-${photo_version}.spk"
echo ${photo_address}
#https://global.download.synology.com/download/Package/spk/SynologyPhotos/1.2.0-0263/SynologyPhotos-x86_64-1.2.0-0263.spk
curl --location  ${photo_address} --output ${photo_version}.spk
mkdir output-spk
sudo LD_LIBRARY_PATH=./hda1Extract/usr/lib/ ./syno_extract_spk -vxf ${photo_version}.spk -C output-spk
cd output-spk
#ls
echo "Extract packages"
mkdir package
tar -C package -xf package.tgz
#ls package
cp -v ./package/usr/lib/libsynophoto-plugin-model.so ../../../../

cd ../../../../

../bin/PatchELFSharp-Linux64/PatchELFSharp "libsynosdk.so.7" "SYNOFSIsRemoteFS" "B8 00 00 00 00 C3"
../bin/PatchELFSharp-Linux64/PatchELFSharp "libsynophoto-plugin-model.so" "_ZN9synophoto6plugin7network9IeNetwork11IsSupportedEv" "B8 00 00 00 00 C3"

cp -v libsynosdk.so.7 ../libsynosdk.so.7
cp -v libsynophoto-plugin-model.so ../libsynophoto-plugin-model.so