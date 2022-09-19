#!/bin/sh

# 7.1
os_main_version=$1
# 42661
os_version=$2

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
#https://global.download.synology.com/download/DSM/release/7.1/42661/DSM_DS920+_42661.pat
#https://cndl.synology.cn/download/DSM/release/7.1/42661-1/DSM_DS920%2B_42661.pat
pat_address="https://global.download.synology.com/download/DSM/release/"${os_main_version}"/"${os_version}"/DSM_DS920%2B_"${os_version}".pat"
echo ${pat_address}
curl --location  ${pat_address} --output ${os_version}.pat

filesize=`ls -l ${os_version}.pat | awk '{ print $5 }'`
minimalsize=$((100*1024*1024))  #100MB

if [ $filesize -gt $minimalsize ]; then
	echo "Download ${os_version}.pat Success"
else
	echo "try again with ${os_version}-1 folder"
    pat_address="https://global.download.synology.com/download/DSM/release/"${os_main_version}"/"${os_version}"-1/DSM_DS920%2B_"${os_version}".pat"
	echo ${pat_address}
	curl --location  ${pat_address} --output ${os_version}.pat
	filesize=`ls -l ${os_version}.pat | awk '{ print $5 }'`
	if [ $filesize -gt $minimalsize ]; then
		echo "Download ${os_version}.pat Success"
	else
		echo "Download ${os_version}.pat failed $?"
		exit
	fi
fi

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
cp -v ./hda1Extract/usr/lib/libsynosdk.so.7 ../../../../

cd ../../../../

../bin/PatchELFSharp-Linux64/PatchELFSharp "libsynosdk.so.7" "SYNOFSIsRemoteFS" "B8 00 00 00 00 C3"

cp -v libsynosdk.so.7 ../libsynosdk.so.7
