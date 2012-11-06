#这个自己调整一下
#include $(LOCAL_PATH)/foo/Android.mk

LOCAL_PATH := $(call my-dir)


include $(CLEAR_VARS)
LOCAL_MODULE := libavcodec
LOCAL_SRC_FILES := ../lib/libavcodec.a
include $(PREBUILT_STATIC_LIBRARY)	

include $(CLEAR_VARS)
LOCAL_MODULE := libavformat
LOCAL_SRC_FILES := ../lib/libavformat.a
include $(PREBUILT_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE := libavutil
LOCAL_SRC_FILES := ../lib/libavutil.a
include $(PREBUILT_STATIC_LIBRARY)


include $(CLEAR_VARS)
LOCAL_MODULE := ffmpeg
LOCAL_WHOLE_STATIC_LIBRARIES := libavutil libavcodec libavformat 
LOCAL_LDLIBS := -lz
include $(BUILD_SHARED_LIBRARY)


