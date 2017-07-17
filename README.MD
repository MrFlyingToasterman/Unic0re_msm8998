# Unic0re
The Unic0re Kernel is a custom Kernel for the OnePlus 5.
<br>

# Linux 4.x
This is basically a fork of the Linux 4.x Kernel from Linus Torwalds. <br>
Origin: https://github.com/torvalds/linux <br>
<br>

# Features
- Suppored filesystems:
    - ext2
    - ext3
    - ext4
    - f2fs
    - NTFS
    - Fat32
    - vFat
    - XFS
    - ZFS
    - BtrFS
    
- Kernel Govanors:
    - Soon
<br>

# Quick build

    $ sh auto-build.sh

# Building the Unic0re Kernel
**Prepare** <br>

    $ mkdir ~/git
    $ cd ~/git
    $ export ARCH=arm64
    $ export SUBARCH=arm64
    $ export CROSS_COMPILE=aarch64-linux-android-
    $ git clone https://github.com/MrFlyingToasterman/android_kernel_oneplus_msm8998
    
**Download a prebuild toolchain (aarch64-gcc4.9)** <br>

    $ git clone https://android.googlesource.com/platform/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9
    
**Create custom Kernelconfig** (this step can be skipt)  

    $ make menuconfig
    
(This should be saved as oneplus5_defconfig)

**Build** <br>

    $ make oneplus5_defconfig
    $ make
<br>

# Flash the Unic0re Kernel

    adb sideload Unicore-OP5-N.zip
    
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
