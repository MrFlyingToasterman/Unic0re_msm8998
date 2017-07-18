# Unic0re
The Unic0re Kernel is a custom Kernel for the OnePlus 5.
<br>

# Linux 4.x
This is basically a fork of the Linux 4.x Kernel from Linus Torwalds. <br>
Origin: https://github.com/torvalds/linux <br>
<br>

# Features
- Supported filesystems:
    - ext2
    - ext3
    - ext4
    - f2fs
    - NTFS
    - Fat32
    - vFat
    - XFS
    - JFS
    - ZFS
    - BtrFS
    - GFS2
    - UDF
    - NFS (client)
    
- Kernel Govanors:
    - Soon

- Support initial ramdisk compressions:
    - gzip
    - bzip2
    - LZMA

<br>

# Quick build

    $ sh auto-build.sh

# Building the Unic0re Kernel
**Prepare** <br>

    $ mkdir ~/git
    $ cd ~/git
    $ export ARCH=arm64
    $ export SUBARCH=arm64
    $ export CROSS_COMPILE=prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-linaro-4.9/bin/aarch64-linux-android-
    $ git clone https://github.com/MrFlyingToasterman/android_kernel_oneplus_msm8998
    
**Download a prebuild toolchain (aarch64-gcc4.9)** <br>

    $ git clone https://android.git.linaro.org/git-ro/platform/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9-linaro.git prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-linaro-4.9
    
**Create custom Kernelconfig** (Only if you know what you are doing)  

    $ make menuconfig oneplus5_defconfig
    
**Build** <br>

    $ make oneplus5_defconfig
    $ make --keep-going -i
    
(You may need to add a "--keep-going" because some modules a prone to crash)
<br>

# Flash the Unic0re Kernel
You can flash the Kernel via:
- fastboot flash boot Unic0re.zip
- adb sideload Unic0re.zip
- A normal TWRP flash

I recommend using TWRP and making a backup, **just in case!!**
    
<br>

# Remark
> **"msm"** is the Kernel tree for Qualcomm chipsets
<br>

# DISCLAIMER
Your warranty is now void. <br>
<br>
We are not responsible for bricked devices, dead SD cards, <br>
thermonuclear war or you getting fired because the alarm app failed. Please <br>
do some research if you have any concerns about features included in this Kernel <br>
before flashing it! YOU are choosing to make these modifications, and if <br>
you point the finger at us for messing up your device, we will laugh at you. <br>
<br>
# License
GPLv2 <a href="https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html">click here</a> to read more.
