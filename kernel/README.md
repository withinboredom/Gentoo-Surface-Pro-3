Here you'll find `.config` files for kernels that should work just fine on your
Surface Pro 3.  Additionally, any patches necessary to get things working
(Kernels < 3.19 need `typecover3.patch`, all kernels need `cameras.patch`) are
included as well.

To patch your kernel, just cd into your kernel directory and apply the patches:

### Kernels older then 3.19

    # cd /usr/src/linux
    # patch -p1 -i /path/to/cameras.patch
    # patch -p1 -i /path/to/typecover3.patch

### Kernels 3.19+

    # cd /usr/src/linux
    # patch -p1 -i /path/to/cameras.patch

The 3.18.x kernels are just the Ubuntu 3.16 kernel repackaged and tweaked
to play nice with Gentoo, so an observant person will find an awful lot of
stuff in there that you don't need.  3.19.2 and up however are manual
configurations, the result of many hours of poking at my Surface and comparing
my kernel with what came out of Ubuntu and `lsmod`.

Note that the 3.19.x kernels currently appear to have an issue with battery
level reporting.  GNOME specifically appears incapable of reporting the current
status of the battery under 3.19.x.

Please feel free to experiement and submit pull requests for configurations
without unnecessary modules, or with compiled-in options where we know the
hardware is present on the SP3.

