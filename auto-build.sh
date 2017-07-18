#! /bin/bash

# Resources
echo "[INFO] Setting up Resources"
THREAD="-j$(grep -c ^processor /proc/cpuinfo)"
KERNEL="zImage"
DEFCONFIG="oneplus5_defconfig"

# Kernel Name
echo "[INFO] Setting up Kernel Details"
VER=Unic0re
VARIANT="OP5-N"

# Var'z
echo "[INFO] Setting up Varz"
export LOCALVERSION=~`echo $VER`
export ARCH=arm64
export SUBARCH=arm64

# Paths
echo "[INFO] Setting up Paths"
REPACK_DIR="android/kernel/repack"
ZIP_MOVE="android/kernel/packed_zip"
ZIMAGE_DIR="arch/arm64/boot"

# Create some working dirs
echo "[INFO] Create some working dirs"
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
echo "[INFO] ENV SETUP"

# Export path of the CROSS_COMPILER
echo "[INFO] Setting up CROSS_COMPILER"
export CROSS_COMPILE=aarch64-linux-android-4.9/bin/aarch64-linux-androidkernel-

# Clone Toolchain from googlesource
echo "[INFO] Clone Googletoolchain from googlesource"
git clone https://android.googlesource.com/platform/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9

# Build the kernel
echo "[INFO] Start Kernel build!"
make $DEFCONFIG
make $THREAD

# Enter REPACK_DIR
echo "[INFO] Enter REPACK_DIR"
cd android/kernel/repack

# Clone AnyKernel2 Template
echo "[INFO] Clone AnyKernel2 from GitHub"
git clone https://github.com/osm0sis/AnyKernel2/
rm AnyKernel2/anykernel.sh

# Use my AnyKernel config
echo "[INFO] Restore AnyKernel conf"
cp ../../../arch/arm64/configs/anykernel ./anykernel.sh

# Merge together
echo "[INFO] Mergeing..."
mv AnyKernel2/* ./
rm -rf AnyKernel2/

# Clean
echo "[INFO] cleaning up"
rm -rf ramdisk/
rm -rf patch/
rm zImage

# Go to root
echo "[INFO] Leaving dir.."
cd ../../../

### ENV READY ###
echo "[INFO] ENV READY"

# Copy the Kernel to REPACK_DIR
echo "[INFO] Copying Kernel to REPACK_DIR"
cp -vr $ZIMAGE_DIR/$KERNEL $REPACK_DIR/zImage

# Enter REPACK_DIR
echo "[INFO] Enter REPACK_DIR"
cd android/kernel/repack

# Zip flashable stuff
echo "[INFO] Creating flashable ZIP!"
zip -r9 "$VER"-"$VARIANT".zip *

# Move flashable Zip to out folder
echo "[INFO] Moving ZIP to ../packed_zip"
mv "$VER"-"$VARIANT".zip ../packed_zip/"[KERNEL] "$VER"-"$VARIANT".zip"

# Show time wasted
DATE_END=$(date +"%s")
DIFF=$(($DATE_END - $DATE_START))
echo "[INFO] Time wasted: $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds."
echo

# Ready
echo "ready."
