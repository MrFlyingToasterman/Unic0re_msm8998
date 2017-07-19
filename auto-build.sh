#! /bin/bash

# Resources
echo "[INFO] Setting up Resources"
THREAD="-j$(grep -c ^processor /proc/cpuinfo)"
KERNEL="Image.gz-dtb"
#DEFCONFIG="oneplus5_defconfig"
DEFCONFIG="msm-perf_defconfig"
HOSTNAME="$(cat /etc/hostname)"
HOSTOS="$(uname -a)"
UPTIME="$(uptime)"
GITV="$(git --version)"

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
echo "[INFO] Welcome to the Unic0re creation script:"
echo ""
echo "[INFO] HOSTNAME  : $HOSTNAME"
echo "[INFO] HOST_OS   : $HOSTOS"
echo "[INFO] UPTIME    : $UPTIME"
echo ""
echo "[INFO] GIT_VER    : $GITV"
echo ""
echo "[INFO] REPACK_DIR: $REPACK_DIR"
echo "[INFO] OUTPUT_DIR: $ZIP_MOVE"
echo "[INFO] KERNEL_DIR: $ZIMAGE_DIR"
echo "[INFO] KERNELNAME: $KERNEL"
echo "[INFO] TARGET    : arm64"
echo "[INFO] KERNELCONF: $DEFCONFIG"
echo "[INFO] TOOLCHAIN : linaro 4.9"
echo ""

# Get current Time
DATE_START=$(date +"%s")

### ENV SETUP ###
echo "[INFO] ENV SETUP"

# Export path of the CROSS_COMPILER
echo "[INFO] Setting up CROSS_COMPILER"
#export CROSS_COMPILE=aarch64-linux-android-4.9/bin/aarch64-linux-androidkernel- ## Google CC
export CROSS_COMPILE=prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-linaro-4.9/bin/aarch64-linux-android-

# Clone Toolchain
echo "[INFO] Cloning Toolchain..."
echo "[WARN] In some cases it looks unproductive. But its working! Please stand by!"
#git clone https://android.googlesource.com/platform/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9 ## Google Toolchain
git clone https://android.git.linaro.org/git-ro/platform/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9-linaro.git prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-linaro-4.9

#Extract tar.xz
#tar -xvf gcc-linaro-7.1.1-2017.05-x86_64_aarch64-linux-gnu.tar.xz

# Cleaning
echo "[INFO] Cleaning Kernelsource..."
make mrproper

# Build the kernel
echo "[INFO] Start Kernel build!"
make $DEFCONFIG
make $THREAD --ignore-errors --keep-going VERBOSE=1 #-o arch/arm64/boot/zImage

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
