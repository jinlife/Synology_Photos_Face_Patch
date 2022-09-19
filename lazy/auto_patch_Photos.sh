#!/bin/sh

# 1.2.0-0263
photo_version=$1

# download old pat for syno_extract_system_patch # thanks for jumkey's idea.
mkdir synoesp
curl --location https://global.download.synology.com/download/DSM/release/7.0.1/42218/DSM_DS3622xs%2B_42218.pat --output oldpat.tar.gz
tar -C ./synoesp/ -xf oldpat.tar.gz rd.gz
cd synoesp

output=$(xz -dc < rd.gz 2>/dev/null | cpio -idm 2>&1)
ls
echo "show usr syno"
ls ./usr/syno/
echo "Start to extract synoarchive"
mkdir extract && cd extract
#ls
echo "cp file synoarchive"
cp -v ../usr/syno/sbin/synoarchive ./
ln -s synoarchive syno_extract_spk

echo "Start patch Photos"
photo_address="https://global.download.synology.com/download/Package/spk/SynologyPhotos/${photo_version}/SynologyPhotos-x86_64-${photo_version}.spk"
echo ${photo_address}
#https://global.download.synology.com/download/Package/spk/SynologyPhotos/1.2.0-0263/SynologyPhotos-x86_64-1.2.0-0263.spk
curl --location  ${photo_address} --output ${photo_version}.spk
mkdir output-spk
sudo LD_LIBRARY_PATH=../usr/lib/ ./syno_extract_spk -vxf ${photo_version}.spk -C output-spk
cd output-spk
#ls
echo "Extract packages"
mkdir package
tar -C package -xf package.tgz
#ls package
cp -v ./package/usr/lib/libsynophoto-plugin-model.so ../../../../../

cd ../../../../../

../bin/PatchELFSharp-Linux64/PatchELFSharp "libsynophoto-plugin-model.so" "_ZN9synophoto6plugin7network9IeNetwork11IsSupportedEv" "B8 00 00 00 00 C3"
cp -v libsynophoto-plugin-model.so ../libsynophoto-plugin-model.so