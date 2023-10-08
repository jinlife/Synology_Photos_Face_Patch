# Synology_Photos_Face_Patch
Synology Photos Facial Recognition Patch

1. This patch will ignore GPU and let DS918+ to have facial recognization function in Synology Photos.
2. DS3615xs might need this patch and it depends on CPU.
3. DS918+ might need this patch and it depends on CPU and GPU, I would strongly recommend to use GPU if it works.
4. Support both face and subject recognition in new version, but please aware it only recognizes face if there is person in the picture. The subject is for none person picture only.
5. For location recognition, it depends on whether your phone has GPS enabled and the location information should be included in the properties of each photo. Synology Photos supports it without any patches.

## Use it at your own risk, you might lose data with this patch.

### Choice1 (No need SSH, Recommend!)
1. Go Control Panel -> Task Scheduler.
2. Click Create -> Scheduled Task -> User-defined script.
3. Select **root** in the user field.
4. Go Task Settings , paste the code as follows in Run Command field .
5. Click OK and Run this Task.

As of V1.6.0-0629, the file was updated from libsynophoto-plugin-**model**.so to libsynophoto-plugin-**platform**.so

```bash
wget https://github.com/jinlife/Synology_Photos_Face_Patch/releases/latest/download/libsynophoto-plugin-platform.so -O /var/packages/SynologyPhotos/target/usr/lib/libsynophoto-plugin-platform.so && synopkgctl stop SynologyPhotos && synopkgctl start SynologyPhotos
```

### Choice2

1. Download libsynophoto-plugin-platform.so and upload it to home folder in Synology
2. SSH connect to Synology and input below command to patch the file.
3. Please change 'jinlife' to your own account.
4. Restart Photos after patch.
```bash
cp /volume1/homes/jinlife/libsynophoto-plugin-platform.so /var/packages/SynologyPhotos/target/usr/lib/ 
```
If the libsynophoto-plugin-platform.so doesn't work, please try libsynophoto-plugin-platform.so.1.0 with same steps.
Or I would recommend to patch it by yourself, please take a look at [link](/bin)

## Misc (libsynosdk.so.7)
The patch for libsynosdk.so.7 will allow remote NFS/CIFS shared folder be used in VideoStation, AudioStation and Photos etc.
```bash
cp /volume1/homes/jinlife/libsynosdk.so.7 /usr/lib/
```
#### Note: 
1. It has side effect for FileStation that you cannot eject the folder anymore, it will be treated as local folder, however you can still umount it.
2. For Photos, it will work perfectly in Shared folder: photo. But you cannot delete picture in personal homes folder. However, you can delete it in FileStation, but it is still inconvienient.
3. Maybe you can upload photo by App "DS File", it can specify the uploaded folder out of homes.
4. Anyway, I would suggest to use it for VideoStation only.
5. Restart DSM after patch.
