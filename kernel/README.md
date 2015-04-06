Here you'll find `.config` files for kernels that should work just fine on your
Surface Pro 3.  Additionally, any patches necessary to get things working are
included as well.

To patch your kernel, just cd into your kernel directory and apply the patches:

### Kernels older then 3.19

    # cd /usr/src/linux
    # patch -p1 -i /path/to/cameras.patch
    # patch -p1 -i /path/to/typecover3.patch

### Kernels 3.19+

    # cd /usr/src/linux
    # patch -p1 -i /path/to/cameras.patch
    # patch -p1 -i /path/to/battery.patch
    # patch -p1 -i /path/to/buttons1.patch
    # patch -p1 -i /path/to/buttons2.patch

The 3.18.x kernels are just the Ubuntu 3.16 kernel repackaged and tweaked
to play nice with Gentoo, so an observant person will find an awful lot of
stuff in there that you don't need.  3.19.2 and up however are manual
configurations, the result of many hours of poking at my Surface and comparing
my kernel with what came out of Ubuntu and `lsmod`.

The early 3.19.x kernels have more patches because new support is being
developed against that tree, so while it looks more sketchy, I'd still
recommend that you build the latest kernel available.

Please feel free to experiement and submit pull requests for configurations
without unnecessary modules, or with compiled-in options where we know the
hardware is present on the SP3.

### A note about Systemd and other diviating configurations

These kernels were developed for use with Systemd, so if you're not planning
on using it, you'll want to change CONFIG_CMDLINE to reflect your environment.
Similarly, if your root partition isn't on `/dev/sda5`, you'll probably want
to tweak that line or drop it altogether in stead opting for something set in
GRUB.

