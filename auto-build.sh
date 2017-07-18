#! /bin/bash

# Resources
THREAD="-j$(grep -c ^processor /proc/cpuinfo)"
KERNEL="zImage"
DEFCONFIG="oneplus5_defconfig"

# Kernel Name
VER=Unic0re
VARIANT="OP5-N"

# Var'z
export LOCALVERSION=~`echo $VER`
export ARCH=arm64
export SUBARCH=arm64

# Paths
REPACK_DIR="android/kernel/repack"
ZIP_MOVE="android/kernel/packed_zip"
ZIMAGE_DIR="arch/arm64/boot"

# Create some working dirs
mkdir android/kernel
mkdir android/kernel/repack
mkdir android/kernel/packed_zip

# Greeting and some Information
echo "[INFO] Unic0re Kernel Creation Script:"
echo ""
echo "[INFO] REPACK_DIR: $REPACK_DIR"
echo "[INFO] OUTPUT_DIR: $ZIP_MOVE"
echo "[INFO] KERNEL_DIR: $ZIMAGE_DIR"
echo "[INFO] KERNELNAME: $KERNEL"
echo "[INFO] TARGET:     arm64"
echo ""

# Get current Time
DATE_START=$(date +"%s")

### ENV SETUP ###

# Export path of the CROSS_COMPILER
export CROSS_COMPILE=aarch64-linux-android-4.9/bin/aarch64-linux-androidkernel-

# Clone Toolchain from googlesource
git clone https://android.googlesource.com/platform/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9

# Build the kernel
make $DEFCONFIG
make $THREAD

# Enter REPACK_DIR
cd android/kernel/repack

# Clone AnyKernel2 Template
git clone https://github.com/osm0sis/AnyKernel2/
rm AnyKernel2/anykernel.sh

# Use my AnyKernel config
cp ../../../arch/arm64/configs/anykernel ./anykernel.sh

# Merge together
mv AnyKernel2/* ./
rm -rf AnyKernel2/

# Clean
rm -rf ramdisk
rm -rf patch
rm zImage

# Go to root
cd ../../../

### ENV READY ###

# Copy the Kernel to REPACK_DIR
cp -vr $ZIMAGE_DIR/$KERNEL $REPACK_DIR/zImage

# Enter REPACK_DIR
cd android/kernel/repack

# Zip flashable stuff
zip -r9 "$VER"-"$VARIANT".zip *

# Move flashable Zip to out folder
mv "$VER"-"$VARIANT".zip ../packed_zip/"[KERNEL] "$VER"-"$VARIANT".zip"

# Show time wasted
DATE_END=$(date +"%s")
DIFF=$(($DATE_END - $DATE_START))
echo "Time: $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds."
echo

# Ready
echo "ready."
