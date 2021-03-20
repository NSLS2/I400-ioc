#!../../bin/linux-x86_64/I400

## You may have to change I400 to something else
## everywhere it appears in this file


< envPaths
< /epics/common/xf07id-ioc1-netsetup.cmd

cd ${TOP}

## configuration for stream
epicsEnvSet ("STREAM_PROTOCOL_PATH", ".:./I400App/src/protocol-files/")

## Register all support components
dbLoadDatabase("./dbd/I400.dbd",0,0)
I400_registerRecordDeviceDriver(pdbbase) 

#######  I404 via com-port #########################
###switch the Ixxx to Mode:3 Address:Dont Care
##
#drvAsynSerialPortConfigure "COM1", "/dev/ttyS0"
#drvAsynSerialPortConfigure "COM1", "/dev/ttyUSB2"
#asynOctetSetInputEos "COM1",0,"\r\n"
#asynOctetSetOutputEos "COM1",0,"\r\n"
#asynSetOption ("COM1", 0, "baud", "115200")
#asynSetOption ("COM1", 0, "bits", "8")
#asynSetOption ("COM1", 0, "parity", "xf07id-cagw-713.nsls2.bnl.local")
#asynSetOption ("COM1", 0, "stop", "1")
#asynSetOption ("COM1", 0, "clocal", "Y")
#asynSetOption ("COM1", 0, "crtscts", "N")


##############  I404 via Moxa TCP Server  #########
##
## drvAsynIPPortConfigure(portName, hostInfo, priority, noAutoConnect, noProcessEos)
drvAsynIPPortConfigure("I400_1", "xf07id-tsrv2.nsls2.bnl.local:4001",0,0,0)
drvAsynIPPortConfigure("I400_2", "xf07id-tsrv4.nsls2.bnl.local:4001",0,0,0)
drvAsynIPPortConfigure("I400_3", "xf07id-tsrv5.nsls2.bnl.local:4002",0,0,0)
drvAsynIPPortConfigure("I400_4", "xf07id-tsrv6.nsls2.bnl.local:4002",0,0,0)
drvAsynIPPortConfigure("I400_5", "xf07id-tsrv8.nsls2.bnl.local:4001",0,0,0)
drvAsynIPPortConfigure("I400_6", "xf07id-tsrv9.nsls2.bnl.local:4001",0,0,0)
##

#asynSetTraceMask("I400_1",0,9)
#asynSetTraceIOMask("I400_1",0,9)

## Load record instances
#dbLoadRecords("./db/I400.db","user=iocuser")
dbLoadTemplate("./db/I400.substitutions")

## Run this to trace the stages of iocInit
#traceIocInit

dbLoadRecords("/epics/iocs/I400/db/reccaster.db", "P=XF:07ID-CT{IOC:I400}RecSync")
iocInit()

## Start any sequence programs
#seq sncI400,"user=iocuser"

###Streamdebug#################################################################
var streamDebug 0
###############################################################################

date
##EOF
