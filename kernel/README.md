Here you'll find `.config` files for kernels that should work just fine on your
Surface Pro 3.  Additionally, any patches necessary to get things working are
included as well.

To patch your kernel, just cd into your kernel directory and apply the
patches:

### Kernels older then 3.19

    # cd /usr/src/linux
    # cp /path/to/linux-3.x.x-gentoo-surfacepro3/.config .
    # patch -p1 -i /path/to/cameras.patch
    # patch -p1 -i /path/to/typecover3.patch

### Kernels 3.19.x

    # cd /usr/src/linux
    # cp /path/to/linux-3.19.x-gentoo-surfacepro3/.config .
    # patch -p1 -i /path/to/cameras.patch
    # patch -p1 -i /path/to/battery.patch
    # patch -p1 -i /path/to/buttons1.patch
    # patch -p1 -i /path/to/buttons2.patch
    # patch -p1 -i /path/to/multitouch.patch

### Kernel 4.1.2

A big thanks to [cydergoth](https://github.com/cydergoth) who did the
majority of the legwork on this one.

    # cd /usr/src/linux
    # cp /path/to/linux-4.1.2-gentoo-surfacepro3/.config .
    # patch -p0 -i /path/to/linux-4.1.2-gentoo-surfacepro3/kernel.patch

### Kernel 4.2.3

Based heavily on cydergoth's work from 4.1.2, this version can be setup
the same way:

    # cd /usr/src/linux
    # cp /path/to/linux-4.2.3-gentoo-surfacepro3/.config .
    # patch -p0 -i /path/to/linux-4.2.3-gentoo-surfacepro3/kernel.patch

### Kernel 4.4.x

With 4.4.x, we now have support for the Surface Pro 4 TypeCover.  Big
thanks to [neoreeps' surface-pro-3 repo](https://github.com/neoreeps/surface-pro-3)
which contained [this handy patch](https://github.com/neoreeps/surface-pro-3/blob/master/wily_surface.patch)
that I adapted to work gentoo-sources' 4.4.0.

    # cd /usr/src/linux
    # cp /path/to/linux-4.4.0-gentoo-surfacepro3/.config .
    # patch -p1 -i /path/to/kernel.patch

### Kernel 4.6.x

The Arch community is much faster than me at collecting all of the right
patches, so I just copied [matthewwardop's patches from his repo](https://github.com/matthewwardrop/linux-surfacepro3)
and applied them here.  The `.config` file is still custom though, since
I don't know how to configure my kernel to use an initrd.

    # cd /usr/src/linux
    # cp /path/to/linux-4.6.1-gentoo-surfacepro3/.config .
    # patch -p1 -i "/path/to/linux-4.6.1-gentoo-surfacepro3/wifi.patch"
    # patch -p1 -i "/path/to/linux-4.6.1-gentoo-surfacepro3/multitouch.patch"
    # patch -p1 -i "/path/to/linux-4.6.1-gentoo-surfacepro3/touchscreen_multitouch_fixes1.patch"
    # patch -p1 -i "/path/to/linux-4.6.1-gentoo-surfacepro3/touchscreen_multitouch_fixes2.patch"

### Kernel 4.9.x

The patches for this kernel are very similar to those from 4.6.x with the
exception of the wifi patch which I imported from [alyptik's repo](https://github.com/alyptik/linux-surfacepro3-rt).

    # cd /usr/src/linux
    # cp /path/to/linux-4.9.0-gentoo-surfacepro3/.config .
    # patch -p1 -i "/path/to/linux-4.6.1-gentoo-surfacepro3/wifi.patch"
    # patch -p1 -i "/path/to/linux-4.6.1-gentoo-surfacepro3/multitouch.patch"
    # patch -p1 -i "/path/to/linux-4.6.1-gentoo-surfacepro3/touchscreen_multitouch_fixes1.patch"
    # patch -p1 -i "/path/to/linux-4.6.1-gentoo-surfacepro3/touchscreen_multitouch_fixes2.patch"

Please feel free to experiment and submit pull requests for
configurations without unnecessary modules, or with compiled-in options
where we know the hardware is present on the SP3.

### A note about Systemd and other deviating configurations

These kernels were developed for use with Systemd, so if you're not
planning on using it, you'll want to change CONFIG_CMDLINE to reflect
your environment. Similarly, if your root partition isn't on
`/dev/sda5`, you'll probably want to tweak that line or drop it
altogether instead opting for something set in GRUB.
