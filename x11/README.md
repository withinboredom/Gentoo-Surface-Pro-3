This is a patch to the X11 xf86-input-evdev driver to attempt to fix the buttons
on the Surface Pro 3 stylus.

To apply this patch, do the following:

    # ebuild /usr/portage/x11-drivers/xf86-input-evdev/xf86-input-evdev-2.9.2.ebuild prepare
    # cd /var/tmp/portage/x11-drivers/xf86-input-evdev-2.9.2/work/xf86-input-evdev-2.9.2/
    # patch -p0 <path to patch>/Gentoo-Surface-Pro-3/x11/evdev.patch 
    # ebuild /usr/portage/x11-drivers/xf86-input-evdev/xf86-input-evdev-2.9.2.ebuild configure
    # ebuild /usr/portage/x11-drivers/xf86-input-evdev/xf86-input-evdev-2.9.2.ebuild compile
    # ebuild /usr/portage/x11-drivers/xf86-input-evdev/xf86-input-evdev-2.9.2.ebuild install 
    # ebuild /usr/portage/x11-drivers/xf86-input-evdev/xf86-input-evdev-2.9.2.ebuild qmerge 

Then restart X11

NOTE: This patch will output debug events to Xorg.0.log!

Tools to diagnose Pen issues

1. Use evtest (as root) to see the raw events the kernel is seeing (these look
   pretty good on my Surface).
2. Use xev -event mouse, or xinput test to see the input events as X11 sees
   them.
3. Use xinput list, xinput props-list to see how xinput sees the device (this is
   useful to see the new button legends).
