#! /bin/bash

# Resources
THREAD="-j$(grep -c ^processor /proc/cpuinfo)"
KERNEL="Image.gz-dtb"
DEFCONFIG="oneplus5_defconfig"

# Kernel Details
VER=Unic0re
VARIANT="OP5-N"

# Vars
export LOCALVERSION=~`echo $VER`
export ARCH=arm64
export SUBARCH=arm64

# Paths
REPACK_DIR="android/kernel/repack"
ZIP_MOVE="android/kernel/packed_zip"
ZIMAGE_DIR="arch/arm64/boot"

mkdir android/kernel
mkdir android/kernel/repack
mkdir android/kernel/packed_zip

echo "Unic0re Kernel Creation Script:"
echo ""
export CROSS_COMPILE=aarch64-linux-android-4.9/bin/aarch64-linux-androidkernel-

git clone https://android.googlesource.com/platform/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9

make $DEFCONFIG
make $THREAD

cp -vr $ZIMAGE_DIR/$KERNEL $REPACK_DIR/zImage

cd $REPACK_DIR

git clone https://github.com/osm0sis/AnyKernel2/

cp ../../../arch/arm64/configs/anykernel ./anykernel.sh

mv AnyKernel2/* ./
rm -rf AnyKernel2/

zip -r9 "$VER"-"$VARIANT".zip *

mv "$VER"-"$VARIANT".zip ../../../$ZIP_MOVE

echo "ready."
