This is a set of patches for Gentoo-sources 4.1.0 Linux kernel to run on a Microsoft Surface Pro 3

To apply these patches emerge =sys-kernel/gentoo-sources-4.1.0-r1

then 

$ cd /usr/src/linux
$ patch -p0 <path to files>/kernel/linux-4.1.0-gentoo-r1-surfacepro3/kernel.patch 
$ cp <path to files>/kernel/linux-4.1.0-gentoo-r1-surfacepro3/config .config

Notes:
This is the config I (Cydergoth) am running. It may not work for you!
These patches are based on the previous set, updated for kernel 4.1.0-r1 by Cydergoth. Blame me for all errors, not danielquinn!

Issues: 
Right mouse click on touchpad sort-of-works, maybe

Working:
Touchscreen 
Type cover keys
Type cover touchpad (see issues about click above)
Docking Station ethernet
Docking Station audio (not tested)
Power switches
Cameras (not tested)
External display with Docking Station mDisplayPort (use xrandr to configure)

