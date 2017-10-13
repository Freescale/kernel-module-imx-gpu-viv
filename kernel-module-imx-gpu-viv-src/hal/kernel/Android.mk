##############################################################################
#
#    Copyright (c) 2005 - 2017 by Vivante Corp.  All rights reserved.
#
#    The material in this file is confidential and contains trade secrets
#    of Vivante Corporation. This is proprietary information owned by
#    Vivante Corporation. No part of this work may be disclosed,
#    reproduced, copied, transmitted, or used in any way for any purpose,
#    without the express written permission of Vivante Corporation.
#
##############################################################################


LOCAL_PATH := $(call my-dir)
include $(LOCAL_PATH)/../../Android.mk.def


#
# galcore.ko
#
include $(CLEAR_VARS)
.PHONY: KBUILD

GALCORE := \
	$(LOCAL_PATH)/../../galcore.ko

ifeq ($(shell expr $(PLATFORM_SDK_VERSION) ">=" 23),1)
KERNEL_CFLAGS ?= KCFLAGS=-mno-android
endif

$(GALCORE):   KBUILD
	@cd $(AQROOT)
	@$(MAKE) -f Kbuild -C $(AQROOT) \
		$(KERNEL_CFLAGS) \
		AQROOT=$(abspath $(AQROOT)) \
		AQARCH=$(abspath $(AQARCH)) \
		AQVGARCH=$(abspath $(AQVGARCH)) \
		ARCH_TYPE=$(ARCH_TYPE) \
		DEBUG=$(DEBUG) \
		VIVANTE_ENABLE_2D=$(VIVANTE_ENABLE_2D) \
		VIVANTE_ENABLE_3D=$(VIVANTE_ENABLE_3D) \
		VIVANTE_ENABLE_VG=$(VIVANTE_ENABLE_VG)

LOCAL_SRC_FILES := \
	../../galcore.ko

LOCAL_GENERATED_SOURCES := \
	$(AQREG) \
	$(VG_AQREG)

LOCAL_GENERATED_SOURCES += \
	$(GALCORE)

ifeq ($(shell expr $(PLATFORM_SDK_VERSION) ">=" 21),1)
  LOCAL_MODULE_RELATIVE_PATH := modules
else
  LOCAL_MODULE_PATH          := $(TARGET_OUT_SHARED_LIBRARIES)/modules
endif

LOCAL_MODULE        := galcore
LOCAL_MODULE_SUFFIX := .ko
LOCAL_MODULE_TAGS   := optional
LOCAL_MODULE_CLASS  := SHARED_LIBRARIES
LOCAL_STRIP_MODULE  := false
include $(BUILD_PREBUILT)

include $(AQROOT)/copy_installed_module.mk

