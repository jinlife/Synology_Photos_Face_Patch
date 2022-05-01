# Synology_Photos_Face_Patch
Synology Photos Facial Recognition Patch

## Here is my Chinese blog to show how to patch
https://blog.jinlife.com/index.php/archives/49/  

1. This patch will ignore GPU and let DS918+ to have facial recognization function in Synology Photos.
2. DS3615xs might need this patch and it depends on CPU.
3. DS918+ might need this patch and it depends on CPU and GPU, I would strongly recommend to use GPU if it works.

## Use it at your own risk, you might lose data with this patch.

1. Download libsynophoto-plugin-model.so and upload it to home folder in Synology
2. SSH connect to Synology and input below command to patch the file.
3. Please change 'jinlife' to your own account.
```bash
cp /volume1/homes/jinlife/libsynophoto-plugin-model.so /var/packages/SynologyPhotos/target/usr/lib/ 
```

Release notes for Synology Photos  
https://www.synology.com/en-global/releaseNote/SynologyPhotos

## Misc (libsynosdk.so.7)
The patch for libsynosdk.so.7 will allow remote NFS/CIFS shared folder be used in VideoStation, AudioStation and Photos etc.
```bash
cp /volume1/homes/jinlife/libsynosdk.so.7 /usr/lib/
```
### Note: 
It has side effect for FileStation that you cannot eject the folder anymore, it will be treated as local folder, however you can still umount it.
For Photos, it will work perfectly in Shared folder: photo. But you cannot delete picture in personal homes folder. However, you can delete it in FileStation, but it is still inconvienient.
Maybe you can upload photo by App "DS File", it can specify the uploaded folder out of homes.
Anyway, I would suggest to use it for VideoStation only.