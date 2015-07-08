This is a set of patches for Gentoo-sources 4.0.5 Linux kernel to run on a Microsoft Surface Pro 3

To apply these patches emerge =sys-kernel/gentoo-sources-4.0.5

then 

$ cd /usr/src/linux
$ patch -p4 <path to files>/kernel/linux-4.0.5-gentoo-surfacepro3/kernel.patch 
$ cp <path to files>/kernel/linux-4.0.5-gentoo-surfacepro3/config .config

Notes:
This is the config I (Cydergoth) am running. It may not work for you!
These patches are based on the previous set, updated for kernel 4.0.5 by Cydergoth. Blame me for all errors, not danielquinn!

Issues: 
Touchscreen not working
Right mouse click on touchpad sort-of-works, maybe

Working:
Type cover keys
Type cover touchpad (see issues about click above)
Docking Station ethernet
Docking Station audio (not tested)
Power switches
Cameras
External display with Docking Station mDisplayPort (use xrandr to configure)


