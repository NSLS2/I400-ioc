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

epicsEnvSet("ENGINEER",  "C. Engineer")
epicsEnvSet("LOCATION", "XF09IDA")
epicsEnvSet ("STREAM_PROTOCOL_PATH", "$(TOP)/I400App/src/protocol-files/")

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

dbLoadRecords("db/asyn.db","Sys=$(SYS),Dev=$(DEV),PORT=COM1,ADDR=0")
dbLoadRecords("$(EPICS_BASE)/db/iocAdminSoft.db","IOC=$(IOC_SYS)$(IOC_DEV)")
dbLoadRecords("$(DEVIOCSTATS)/db/iocAdminSoft.db", "IOC=$(IOC_SYS)$(IOC_DEV)")
dbLoadRecords("$(AUTOSAVE)/db/save_restoreStatus.db", "P=$(IOC_SYS)$(IOC_DEV)")
dbLoadRecords("${TOP}/db/reccaster.db", "P=${IOC_SYS}$(IOC_DEV)RecSync")

# autosave/restore mechanisms
save_restoreSet_Debug(0)
save_restoreSet_IncompleteSetsOk(1)
save_restoreSet_DatedBackupFiles(1)

set_savefile_path("${TOP}/as","/save")
set_requestfile_path("${TOP}/as","/req")
set_requestfile_path("${EPICS_BASE}/as","/req")

set_pass0_restoreFile("info_settings.sav")
set_pass0_restoreFile("info_positions.sav")
set_pass1_restoreFile("info_settings.sav")

makeAutosaveFileFromDbInfo("$(TOP)/as/req/info_settings.req", "autosaveFields")
makeAutosaveFileFromDbInfo("$(TOP)/as/req/info_positions.req", "autosaveFields_pass0")

iocInit()

create_monitor_set("info_settings.req", 30)
create_monitor_set("info_positions.req", 15)

###Streamdebug#################################################################
var streamDebug 0
###############################################################################

dbl > $(TOP)/records.dbl

date
##EOF
