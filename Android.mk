# Included by top-level Android.mk
LOCAL_PATH:= $(call my-dir)
include external/olsrd/make/sourcefiles.mk
OLSRD_SRC_FILES = $(OLSRD_SOURCES)

# Build libolsrd.so
include $(CLEAR_VARS)
LOCAL_SRC_FILES:= $(OLSRD_SRC_FILES)
LOCAL_CFLAGS += $(OLSRD_LOCAL_CFLAGS) -I$(LOCAL_PATH)/src/ -I$(LOCAL_PATH)/android/ -DJNI -DINET_ADDRSTRLEN=16 -D'IPTOS_PREC(tos)=((tos)&0xe0)' -D'IPTOS_TOS(tos)=((tos)&0x1e)'
LOCAL_LDLIBS := $(OLSRD_LOCAL_LDLIBS) -llog
LOCAL_STATIC_LIBRARIES := $(OLSRD_LOCAL_STATIC_LIBRARIES)
LOCAL_MODULE_FILENAME:=libolsrd
LOCAL_MODULE:= olsrd
include $(BUILD_SHARED_LIBRARY)
