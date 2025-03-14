#!../../bin/linux-x86_64/I400

## You may have to change I400 to something else
## everywhere it appears in this file


< envPaths
< /epics/common/xf09id1-ioc1-netsetup.cmd

epicsEnvSet("SYS", "XF:09IDA-BI")
epicsEnvSet("DEV", "{i400:1}")
epicsEnvSet("IOC_SYS", "XF:09IDA-CT")
epicsEnvSet("IOC_DEV", "{IOC:i400}")

cd ${TOP}

## configuration for stream
epicsEnvSet ("STREAM_PROTOCOL_PATH", ".:./I400App/src/protocol-files/")

## Register all support components
dbLoadDatabase("./dbd/I400.dbd",0,0)
I400_registerRecordDeviceDriver(pdbbase) 

##############  I404 via Moxa TCP Server  #########
##
## drvAsynIPPortConfigure(portName, hostInfo, priority, noAutoConnect, noProcessEos)
drvAsynIPPortConfigure("I400_1", "10.66.66.83:4001",0,0,0)
##

#asynSetTraceMask("I400_1",0,9)
#asynSetTraceIOMask("I400_1",0,9)

## Load record instances
dbLoadTemplate("./db/I400.substitutions", "Sys=$(SYS),Dev=$(DEV)"))

## Run this to trace the stages of iocInit
#traceIocInit

dbLoadRecords("/epics/iocs/I400/db/reccaster.db", "P=$(IOC_SYS)$(IOC_DEV)RecSync")
iocInit()

###Streamdebug#################################################################
var streamDebug 0
###############################################################################

dbl > $(TOP)/records.dbl

date
##EOF
