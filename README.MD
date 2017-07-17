# Unic0re
The Unic0re Kernel is a custom Kernel for the OnePlus 5.

# Linux 4.x
This is basically a fork of the Linux 4.x Kernel from Linus Torwalds. <br>
Origin: https://github.com/torvalds/linux <br>

# Building the Unic0re Kernel
**Prepare** <br>

    $ mkdir ~/git
    $ cd ~/git
    $ git clone https://github.com/MrFlyingToasterman/android_kernel_oneplus_msm8998
    
    <br>
**Download a prebuild toolchain (aarch64-gcc4.9)** <br>

    $ git clone https://android.googlesource.com/platform/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9
    
**Build** <br>

    $ export ARCH=arm64
    $ export CROSS_COMPILE=aarch64-linux-android-
    $ cd hikey-linaro
    $ make hikey_defconfig
    $ make
    
# Remark
> "msm" is the Kernel tree for Qualcomm chipsets

# License
GPLv2
