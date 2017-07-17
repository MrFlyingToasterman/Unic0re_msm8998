# AnyKernel2 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# EDIFY properties
kernel.string=Unic0re
do.devicecheck=0
do.modules=0
do.cleanup=0
do.cleanuponabort=0
device.name1=maguro
device.name2=toro
device.name3=toroplus
device.name4=
device.name5=

# shell variables
block=/dev/block/bootdevice/by-name/boot;
is_slot_device=0;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. /tmp/anykernel/tools/ak2-core.sh;


## AnyKernel permissions
# set permissions for included ramdisk files
chmod -R 755 $ramdisk
chmod 644 $ramdisk/sbin/media_profiles.xml


## AnyKernel install
dump_boot;

# begin ramdisk changes

# end ramdisk changes

write_boot;

## end install
