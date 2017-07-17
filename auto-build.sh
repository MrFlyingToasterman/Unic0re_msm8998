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
KERNEL_DIR="android/kernel/op5"
REPACK_DIR="android/kernel/repack"
ZIP_MOVE="android/kernel/out/op5"
ZIMAGE_DIR="arch/arm64/boot"

function make_kernel {
	  git clone https://android.googlesource.com/platform/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9
		echo
		make $DEFCONFIG
		make $THREAD
 	cp -vr $ZIMAGE_DIR/$KERNEL $REPACK_DIR/zImage
}

function make_zip {
		echo $REPACK_DIR
		cd $REPACK_DIR
		git clone https://github.com/osm0sis/AnyKernel2/
		zip -r9 "$VER"-"$VARIANT".zip *
		mv "$VER"-"$VARIANT".zip $ZIP_MOVE
		cd $KERNEL_DIR
}


DATE_START=$(date +"%s")

echo "Unic0re Kernel Creation Script:"
export CROSS_COMPILE=aarch64-linux-android-4.9/bin/aarch64-linux-androidkernel-
echo

make_kernel
make_zip

echo "-------------------"
echo "Build Completed in:"
echo "-------------------"

DATE_END=$(date +"%s")
DIFF=$(($DATE_END - $DATE_START))
echo "Time: $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds."
echo
