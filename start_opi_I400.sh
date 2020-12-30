#!/bin/sh
#/opt/epics/extensions/bin/linux-x86_64/edm -m "DEVICE=DDSSS-TT-CCCCC-NN" -x /opt/epics/opi/opi_I400/I400.edl 
cd ./opi_I400/
edm -m "P=FMBB,R=BCM01,NAME=BCM01-(I404)" -x ./I400.edl &
