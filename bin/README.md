# Patch by yourself

Run patch.sh in your Synology folder.
## Or
Download the windows exe and run it in windows command line.

Refer to last two lines:
```
if [[ ! -e PatchELFSharp || ! -s PatchELFSharp ]];then
	wget https://raw.githubusercontent.com/jinlife/Synology_Photos_Face_Patch/main/bin/PatchELFSharp-Linux64/PatchELFSharp -O PatchELFSharp
	if [[ ! -e PatchELFSharp || ! -s PatchELFSharp ]];then
		echo "download failed"
		exit
	fi
fi

./PatchELFSharp "/usr/lib/libsynosdk.so.7" "SYNOFSIsRemoteFS" "B8 00 00 00 00 C3"
./PatchELFSharp "/var/packages/SynologyPhotos/target/usr/lib/libsynophoto-plugin-model.so" "_ZN9synophoto6plugin7network9IeNetwork11IsSupportedEv" "B8 00 00 00 00 C3"
```