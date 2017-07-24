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

<br>

# Building issue
Currently, there is a building problem! <br>
You currently need the complete source to build the kernel! <br>
<a href="https://github.com/OnePlusOSS/android_kernel_oneplus_msm8998/issues/3">More information</a> about this error.
<br>
How to build with complete source: <br> <br>
$ mkdir ~/git && cd ~/git && mkdir oneplus_dev <br>
$ git clone https://github.com/android/tools_repo <br>
$ cd oneplus_dev <br>
$ python2 ../tools_repo/repo init -u git://github.com/OnePlusOSS/android.git -b oneplus/QC8998_N_7.1 --depth=1 <br>
$ repo sync <br>
<br>
2. Root your device  
3. Pull the necessary libraries from your device by executing the script `pull_library.sh`  
4. After pull_library.sh be executed, a directory  named "vendor" should be generated. Copy this directory to root of project.

**[Set up environment]**  
Initialize the environment with the envsetup.sh script.  git a
`$ . build/envsetup.sh`  
**[Choose a Target]**  
Choose which target to build with lunch.  
`$ lunch`  
      enter **32 for msm8998-userdebug
              33 for msm8998-user

**[Build the code]**  
Build everything with make. GNU make can handle parallel tasks with a -jN argument.  
`$ make -j4`  
**[Flash a Device]**  
Let device enter fastboot mode, run  
`$ adb reboot bootloader`  
Once the device is in fastboot mode, run  
`$ fastboot flash boot boot.img`  
`$ fastboot flash system system.img`  
If you want flash new /data partition, run  
`$ fastboot flash userdata userdata.img`


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

    $ make msmcortex_defconfig
    $ make --keep-going -i
    
(You may need to add a "--keep-going" because some modules a prone to crash)
<br>

# Flash the Unic0re Kernel
You can flash the Kernel via:
- fastboot
> fastboot flash boot Unic0re.img   
- adb
> adb sideload Unic0re.zip
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
