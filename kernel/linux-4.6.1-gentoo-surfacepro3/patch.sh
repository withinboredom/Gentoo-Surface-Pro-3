#!/usr/bin/env bash

srcdir=${1}

patch -p1 -i "${srcdir}/wifi.patch"
patch -p1 -i "${srcdir}/multitouch.patch"
patch -p1 -i "${srcdir}/touchscreen_multitouch_fixes1.patch"
patch -p1 -i "${srcdir}/touchscreen_multitouch_fixes2.patch"
