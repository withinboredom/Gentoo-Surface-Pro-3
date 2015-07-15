This is a patch to the X11 xf86-input-evdev driver to attempt to fix the buttons on the Surface Pro 3 stylus

To apply this patch, do the following:

# ebuild /usr/portage/x11-drivers/xf86-input-evdev/xf86-input-evdev-2.9.2.ebuild prepare
# cd /var/tmp/portage/x11-drivers/xf86-input-evdev-2.9.2/work/xf86-input-evdev-2.9.2/
# patch -p0 <path to patch>/Gentoo-Surface-Pro-3/x11/evdev.patch 
# ebuild /usr/portage/x11-drivers/xf86-input-evdev/xf86-input-evdev-2.9.2.ebuild configure
# ebuild /usr/portage/x11-drivers/xf86-input-evdev/xf86-input-evdev-2.9.2.ebuild compile
# ebuild /usr/portage/x11-drivers/xf86-input-evdev/xf86-input-evdev-2.9.2.ebuild install 
# ebuild /usr/portage/x11-drivers/xf86-input-evdev/xf86-input-evdev-2.9.2.ebuild qmerge 

Then restart X11

NOTE: This patch will output debug events to Xorg.0.log !
