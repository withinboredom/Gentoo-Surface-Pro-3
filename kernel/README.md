Here you'll find `.config` files for kernels that should work just fine on your
Surface Pro 3.  Additionally, any patches necessary to get things working are
included as well.

To patch your kernel, just cd into your kernel directory and apply the patches:

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

A big thanks to [cydergoth](https://github.com/cydergoth) who did the majority
of the legwork on this one.

    # cd /usr/src/linux
    # cp /path/to/linux-4.1.2-gentoo-surfacepro3/.config .
    # patch -p0 -i /path/to/linux-4.1.2-gentoo-surfacepro3/kernel.patch

### Kernel 4.2.3

Based heavily on cydergoth's work from 4.1.2, this version can be setup the
same way:

    # cd /usr/src/linux
    # cp /path/to/linux-4.2.3-gentoo-surfacepro3/.config .
    # patch -p0 -i /path/to/linux-4.2.3-gentoo-surfacepro3/kernel.patch

### Kernel 4.4.0

With 4.4.x, we now have support for the Surface Pro 4 TypeCover.  Big thanks
to [neoreeps' surface-pro-3 repo](https://github.com/neoreeps/surface-pro-3)
which contained [this handy patch](https://github.com/neoreeps/surface-pro-3/blob/master/wily_surface.patch)
that I adapted to work gentoo-sources' 4.4.0.

    # cd /usr/src/linux
    # cp /path/to/linux-4.4.0-gentoo-surfacepro3/.config .
    # patch -p1 -i /path/to/kernel.patch


The 3.18.x kernels are just the Ubuntu 3.16 kernel repackaged and tweaked
to play nice with Gentoo, so an observant person will find an awful lot of
stuff in there that you don't need.  3.19.2 and up however are manual
configurations, the result of many hours of poking at my Surface and comparing
my kernel with what came out of Ubuntu and `lsmod`.  At this point, you should
probably not be looking at these old kernels.  Use the 4.x ones instead as
they're specifically developed for the Surface.

Please feel free to experiment and submit pull requests for configurations
without unnecessary modules, or with compiled-in options where we know the
hardware is present on the SP3.

### A note about Systemd and other deviating configurations

These kernels were developed for use with Systemd, so if you're not planning
on using it, you'll want to change CONFIG_CMDLINE to reflect your environment.
Similarly, if your root partition isn't on `/dev/sda5`, you'll probably want
to tweak that line or drop it altogether instead opting for something set in
GRUB.

