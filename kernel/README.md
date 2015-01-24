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

Presently, this is just the Ubuntu 3.16 kernel repackaged and tweaked to play
nice with Gentoo, so an observant person will find an awful lot of stuff in
there that you don't need.  Please feel free to experiement and submit pull
requests for configurations without unnecessary modules, or with compiled-in
options where we know the hardware is present on the SP3.

