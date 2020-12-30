TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE
#=============================

#=============================
# Build the IOC application

PROD_IOC = I400
# I400.dbd will be created and installed
DBD += ${PROD_IOC}.dbd

# I400.dbd will be made up from these files:
${PROD_IOC}_DBD += base.dbd

${PROD_IOC}_DBD += stream.dbd
${PROD_IOC}_DBD += asyn.dbd
${PROD_IOC}_DBD += drvAsynIPPort.dbd
${PROD_IOC}_DBD += calcSupport.dbd
#http://epics.web.psi.ch/software/streamdevice/doc/setup.html#app
${PROD_IOC}_DBD += I400AppInclude.dbd
#${PROD_IOC}_DBD += uIOCSystem.dbd


# Include dbd files from all support applications:
#${PROD_IOC}_DBD += xxx.dbd

# Add all the support libraries needed by this IOC
#I400_LIBS += xxx
${PROD_IOC}_LIBS += calc
${PROD_IOC}_LIBS += stream
${PROD_IOC}_LIBS += asyn
#${PROD_IOC}_LIBS += uIOCSystem
${PROD_IOC}_LIBS += ${EPICS_BASE_IOC_LIBS}

# I400_registerRecordDeviceDriver.cpp derives from I400.dbd
${PROD_IOC}_SRCS += I400_registerRecordDeviceDriver.cpp

# Build the main IOC entry point on workstation OSs.
${PROD_IOC}_SRCS_DEFAULT += I400Main.cpp
${PROD_IOC}_SRCS_vxWorks += -nil-

# Add support from base/src/vxWorks if needed
#I400_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

# Finally link to the EPICS Base libraries
${PROD_IOC}_LIBS += $(EPICS_BASE_IOC_LIBS)

#===========================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

