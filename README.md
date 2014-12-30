Gentoo Linux on the Surface Pro 3
=================================

This is a repository for all the tweaks and tricks required to get Gentoo
Linux installed on a Microsoft Surface Pro 3.

The process for this is heavily cribbed from
[this Winero article](http://winaero.com/blog/how-to-install-linux-on-surface-pro-3/),
but with the addition of making things work in Gentoo as well as other bits of
research found elsewhere.


# Important Notes:

* Use [SystemRescueCD](http://www.sysresccd.org/) as it supports booting from
  EFI which is necessary as the Surface Pro 3 doesn't have a fallback BIOS
  mode.
* Do **not** remove the Windows partition.  Instead, resize it, either with
  a Windows-based partitioner, or with gparted.
* You need to keep Windows on there, unless you're super-brave and/or
  overconfident.  At the very least you'll need it if you ever want firmware
  updates, but more likely you'll want it to boot into when things go wrong
  with your Linux bootup.


# A Quick Howto

You Will Need:

* A USB keyboard
* Either a USB hub or a Micro SD card

1.  Disable SecureBoot.  Unless you'd like to go through the effort of
    figuring out how to get it working in Linux, it's probably best just to
    turn this off.  You can do this by booting into the UEFI via windows, or
    by the following *"secret handshake"*:

    1. Turn off your Surface
    2. Hold down the volume-up rocker
    3. While holding down the volume-up rocker push the power button once
    4. Wait until you see the Surface startup logo, then let got of the volume.
    
    Once in there, you can turn off SecureBoot.  Note that from here-on-in, if
    you've updated your firmware, the Surface logo will be on an ugly red
    field at boot time.  It's annoying I know.  Blame Microsoft.

2.  Follow SystemRescueCD's instructions for putting it on a USB stick.  Use
    these instructions to put it either on a USB stick (in your USB hub), or
    onto your Micro SD.
3.  Boot into Windows and use it to boot off of the USB or SD card
4.  Start the gui. I know it sounds silly, but the command line stuff doesn't
    seem to like the wifi adapter, and the USB ethernet adapter proved to be
    flaky as well.
5.  Use the gui to connect to your wifi.
6.  Open a terminal and follow the Gentoo installation handbook, using the
    following partitioning scheme:

        /dev/sda1       2048    739327    737280  360M Windows recovery environment
        /dev/sda2     739328   1148927    409600  200M EFI System
        /dev/sda3    1148928   1411071    262144  128M Microsoft reserved
        /dev/sda4    1411072 103811071 102400000 48.8G Microsoft basic data
        /dev/sda5  103811072 500117503 396306432  189G Linux filesystem

    Be sure to use gparted or a modern version of fdisk that supports GPT!
    [gdisk](http://www.rodsbooks.com/), the graphical partitioner makes this
    easy.

7.  Emerge `dev-vcs/git` and then checkout the Marvell repo of drivers and
    such to somewhere out-of-the-way.  Then create a symlink so your kernel
    sources can find it:

        # emerge dev-vcs/git
        # git clone git://git.marvell.com/mwifiex-firmware.git /opt/mwifiex-firmware/
        # ln -s /opt/mwifiex-firmware/mrvl /lib/firmware/mrvl

8.  Continue with the install, and when you get to the kernel compilation
    step, emerge `gentoo-sources` and then copy the relevant `.config` file
    from this repo into `/usr/src/linux/`.  From there, run `make oldconfig`
9.  If you're building a kernel <3.19, you'll need to patch your sources with
    the patch file in this repo.
10. When you're ready, build and install.  This will take about an hour:

        # make -j5 && make -j5 modules_install && make install

11. Do the rest of the install, making sure to install GRUB with:

        # grub2-install --target=x86_64-efi

12. Finally, you need to emerge `efibootmgr` and run the following command to
    configure your shiny new toy:

        # emerge sys-boot/efibootmgr
        # efibootmgr --bootorder 0000,0002,0001


# Notes

I opted for a Systemd setup, so while I can declare that the above works for
me, if you're using OpenRC, your mileage may vary.


# Troubleshooting

> Oh Noes! What Have I Done?!?

The thing you really have to worry about is a kernel panic while (a) not using
Grub, or with a really short timeout.  If you've configured EFI to boot with
Linux first, *it simply won't boot from USB or Windows at start time*.  In
fact, while fiddling with `efibootmgr` I found that often even with USB first
in the boot order, it would ignore bootable USB media and just boot the second
item -- Linux in my case.

The fix for this is a *"magic handshake"*: you need to:

1. Turn off your Surface
2. Hold down the volume-up rocker
3. While holding down the volume-up rocker push the power button once
4. Wait until you see the Surface startup logo, then let got of the volume.

This *might* work.  If it doesn't, I suggest variations on the above.  Try the
volume-down button, try holding the power button longer, etc.  You should also
try booting into the UEFI and fiddling with the options there, including
turning SecureBoot on and off.  I can't remember which combination of these
have worked in the past, but eventually, this button mashing results in an
overwriting of the boot order with boot-to-windows as the default.  Now you
can start up with SystemRescueCD and fix whatever you broke.


# Fork Me

Pull requests are welcome.  In fact, they'd be downright awesome.

