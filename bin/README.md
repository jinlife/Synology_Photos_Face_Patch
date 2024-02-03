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
# support face and concept
./PatchELFSharp "/var/packages/SynologyPhotos/target/usr/lib/libsynophoto-plugin-platform.so" "_ZN9synophoto6plugin8platform20IsSupportedIENetworkEv" "B8 00 00 00 00 C3"
# force to support concept
./PatchELFSharp "/var/packages/SynologyPhotos/target/usr/lib/libsynophoto-plugin-platform.so" "_ZN9synophoto6plugin8platform18IsSupportedConceptEv" "B8 01 00 00 00 C3"
# force no Gpu
./PatchELFSharp "/var/packages/SynologyPhotos/target/usr/lib/libsynophoto-plugin-platform.so" "_ZN9synophoto6plugin8platform23IsSupportedIENetworkGpuEv" "B8 00 00 00 00 C3"
```