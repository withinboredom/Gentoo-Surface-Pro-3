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
  mode. If you want to use a pure Gentoo build, then the utility
  [Rufus](https://rufus.akeo.ie/) can be used to make an EFI-compatible USB
  stick from the Gentoo Live ISO.
* Do **not** remove the Windows partition.  Instead, resize it, either with
  a Windows-based partitioner, or with gparted. If your windows partition is
  encrypted with bitlocker, you will need to use the dislocker utility to access
  it.
> Note: dislocker is in beta and may destroy your data!  Though this has been
> shown to work just fine for some users, your mileage may vary.

* You need to keep Windows on there, unless you're super-brave and/or
  overconfident.  At the very least you'll need it if you ever want firmware
  updates, but more likely you'll want it to boot into when things go wrong
  with your Linux settup.


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
    4. Wait until you see the Surface startup logo, then let go of the volume.
    
    Once in there, you can turn off SecureBoot.  Note that from here-on-in, if
    you've updated your firmware, the Surface logo will be on an ugly red
    field at boot time.  It's annoying I know.  Blame Microsoft.

2.  Follow SystemRescueCD's instructions for putting it on a USB stick.  Use
    these instructions to put it either on a USB stick (in your USB hub), or
    onto your Micro SD. If you want to use a Gentoo Live ISO, use Rufus and be
    sure to select the *EFI compatible GPT partition format*.
3.  Boot into Windows and use it to boot off of the USB or SD card
4.  Start the gui. I know it sounds silly, but the command line stuff doesn't
    seem to like the wifi adapter, and the USB ethernet adapter proved to be
    flaky as well. Gentoo's Live ISO also doesn't work with wifi, but does with 
    the docking station Ethernet.
5.  Use the gui to connect to your wifi.
6.  Open a terminal and follow the Gentoo installation handbook, (or [Sakaki's 
    excellent guide](https://wiki.gentoo.org/wiki/Sakaki%27s_EFI_Install_Guide))
    using the following partitioning scheme:

        /dev/sda1       2048    739327    737280  360M Windows recovery environment
        /dev/sda2     739328   1148927    409600  200M EFI System
        /dev/sda3    1148928   1411071    262144  128M Microsoft reserved
        /dev/sda4    1411072 103811071 102400000 48.8G Microsoft basic data
        /dev/sda5  103811072 500117503 396306432  189G Linux filesystem

    Be sure to use [gparted](http://gparted.org/) or
    [gdisk](http://www.rodsbooks.com/)), as you'll need to support GPT.

7.  Emerge `dev-vcs/git` and then checkout the Marvell repo of drivers and
    such to somewhere out-of-the-way.  Then create a symlink so your kernel
    sources can find it:

        # emerge dev-vcs/git
        # git clone git://git.marvell.com/mwifiex-firmware.git /opt/mwifiex-firmware/
        # ln -s /opt/mwifiex-firmware/mrvl /lib/firmware/mrvl

8.  Continue with the install, and when you get to the kernel compilation
    step, emerge `gentoo-sources` and then copy the relevant `.config` file
    from this repo into `/usr/src/linux/`.

9.  Patch your kernel.  If you're building kernel >=3.19.0, you only need the
    `cameras.patch` file in this repo (it should be in the appropriate kernel
    folder).  If your kernel is older than that, you'll also need the
    `typecover.patch` file as well.  Instructions on how to do this can be
    found in the `README.md` file in the `kernel` folder of this repo.

10. Run `make oldconfig` just in case.

11. Build and install your new kernel.  This will take about an hour since the
    current `.config` we've got still needs some customisation for this
    device:

        # make -j5 && make -j5 modules_install && make install

12. Do the rest of the install, making sure to install GRUB with:

        # grub2-install --target=x86_64-efi

    Note that Sakaki's scripts do this for you if you're following his build
    guide for EFI.

13. Finally, you need to emerge `efibootmgr` and run the following command to
    configure your shiny new toy:

        # emerge sys-boot/efibootmgr
        # efibootmgr --bootorder 0000,0002,0001


# Once You're Up and Running

I opted for a Systemd setup, so while I can declare that the above works
for me, if you're using OpenRC, your mileage may vary.  Regardless, once
you've got a functional system, there are still a few things to do:

# EFI and USB

The Surface Pro 3 EFI bios has an annoying bug. On boot it seems to scan
the USB bus and create a new EFI boot entry for any device it finds, even
if one exists already with the same GPT partition UUID.  The new entry
overrides the correct existing entry with an incorrect one. This means that you
may have to resort to moving the linux files onto the internal EFI partition, as
documented in Sakaki's guide mentioned above.

# HiDPI

The first thing you'll notice when you start up any GUI environment is that
everything is **really** small.  This is because your Surface Pro 3 has HiDPI
support (aka retina display) and your GUI hasn't been configured to understand
that yet.

Take a look at [Arch Wiki's HiDPI page](https://wiki.archlinux.org/index.php/HiDPI)
for more info on what you can do to make things readable.  Currently, Firefox
looks great, as do many GNOME apps.  Some stuff... not so much.

## Bluetooth

If you followed the above steps, everything you need should be available, you
just need to turn on Bluetooth:

    # systemctl start bluetooth
    # systemctl enable bluetooth

Check out the [Gentoo Bluetooth Guide](https://wiki.gentoo.org/wiki/Bluetooth)
for more info.

You'll find that pairing the pen with your Surface is easy, but my experience
has been that once paired, it disconnects almost immediately.  Tips on what's
going on here are appreciated.

## Rotation

It's a tablet right?  It'd be nice if it could act like one.  For this, Xorg
already does everything you need with its `xinput` and `xrandr` utilities, you
just need a script to do the work for you:

* `emerge xinput` You'll need this for the supplied script to work
* Copy or symlink the `rotate` script in this repo at `usr/local/bin/rotate`
  into your own `/usr/local/bin/` directory
* Copy or symlink the `rotate.desktop` file in this repo at `home/user/.local/share/applications/rotate.desktop`
  to `${HOME}/.local/share/applications/rotate.desktop`.

Now you can rotate the screen simply by typing `rotate` in a shell, or running
the `rotate.desktop` file in GNOME or KDE.


# Support Status

As of the latest kernel in this repository, most features of the Surface are
supported:


## Working (tested)

* Touchscreen
* TypeCover keys
* TypeCover touchpad
* Windows button
* Power button
* Cameras
* Pen with the evdev config from the X11 directory


## Should be working

* External display with Docking Station mDisplayPort (use xrandr to configure)
* Docking Station ethernet
* Docking Station audio


## Problematic

Sensors work if read from the "raw" devices but fail if buffered reads are used


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
3. While holding down the volume-down rocker push the power button once
4. Wait until you see the Surface startup logo, then let go of the volume.

This *might* work.  If it doesn't, I suggest variations on the above.  Try the
volume-down button, try holding the power button longer, etc.  You should also
try booting into the UEFI and fiddling with the options there, including
turning SecureBoot on and off.  I can't remember which combination of these
have worked in the past, but eventually, this button mashing results in an
overwriting of the boot order with boot-to-windows as the default.  Now you
can start up with SystemRescueCD and fix whatever you broke.


# Fork Me

Pull requests are welcome.  In fact, they'd be downright awesome.


# Credits

I've cobbled this repo together through tutorials online and patches submitted
to [/r/SurfaceLinux](https://www.reddit.com/r/SurfaceLinux).  I haven't always
been very good at attributing credit for these works, but I'll try to do better
in the future.

* The initial tutorial for [installing Debian](http://winaero.com/blog/how-to-install-linux-on-surface-pro-3/)
  on the Surface Pro 3
* The Xorg config and multitouch patch were provided by [felipeota](https://github.com/felipeota)
* The button patches were found on the kernel testing branch
  [[1](https://bugzilla.kernel.org/attachment.cgi?id=171291&action=diff&context=patch&collapsed=&headers=1&format=raw)]
  [[2](https://bugzilla.kernel.org/attachment.cgi?id=171281&action=diff&context=patch&collapsed=&headers=1&format=raw)]
* The battery patch was on the [kernel.org mailing list](http://marc.info/?l=linux-acpi&m=142785305602658&w=2)
* Multiple pull requests and help have been supplied by [cydergoth](https://github.com/cydergoth)
