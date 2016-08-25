#
# Copyright (C) 2014 MediaTek Inc.
# Modification based on code covered by the mentioned copyright
# and/or permission notice(s).
#
#
# Copyright (C) 2013 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

LOCAL_PATH := $(call my-dir)

#
# Build app code.
#
include $(CLEAR_VARS)

LOCAL_MODULE_TAGS := optional

LOCAL_JAVA_LIBRARIES += mediatek-framework
LOCAL_JAVA_LIBRARIES += framework
LOCAL_JAVA_LIBRARIES += mediatek-common

LOCAL_STATIC_JAVA_LIBRARIES := \
    android-support-v13 \
    android-support-v4 \
    v7-recyclerview \
    com.mediatek.launcher3.ext \
    answers \
    beta \
    crashlytics \
    crashlytics-core \
    fabric \
    tweet-ui \
    twitter \
    twitter-core \
    tweet-composer \
    twitter-unity \
    digits \
    YouTubeAndroidPlayerApi \
    gson \
    universal-image-loader \
    retrofit \
	com.google.android.gms.measurement \
    com.google.android.gms.analytics \
	com.google.android.gms.base \
	com.google.android.gms.gcm \
	com.google.android.gms \
	com.google.android.gms.location \
	com.google.android.gms.maps \
	com.mediatek.launcher3.ext

#LOCAL_STATIC_JAVA_LIBRARIES += com.mediatek.launcher3.ext


LOCAL_SRC_FILES := $(call all-java-files-under, src) \
    $(call all-java-files-under, WallpaperPicker/src) \
    $(call all-renderscript-files-under, src) \
    $(call all-proto-files-under, protos)
LOCAL_RESOURCE_DIR := $(LOCAL_PATH)/WallpaperPicker/res \
    $(LOCAL_PATH)/res

#    $(LOCAL_PATH)/../../../prebuilts/sdk/current/support/v7/recyclerview/res

LOCAL_AAPT_FLAGS := --auto-add-overlay

LOCAL_PROTOC_OPTIMIZE_TYPE := nano
LOCAL_PROTOC_FLAGS := --proto_path=$(LOCAL_PATH)/protos/
#LOCAL_AAPT_FLAGS := \
#    --auto-add-overlay \
#    --extra-packages android.support.v7.recyclerview

#LOCAL_SDK_VERSION := 21

LOCAL_PACKAGE_NAME := Launcher3WithLefty
LOCAL_CERTIFICATE := shared
LOCAL_PRIVILEGED_MODULE := true
ifeq (OP09,$(word 1,$(subst _, ,$(OPTR_SPEC_SEG_DEF))))
    LOCAL_PRIVILEGED_MODULE := true
endif

LOCAL_OVERRIDES_PACKAGES := Launcher2 Launcher3

LOCAL_PROGUARD_FLAG_FILES := proguard.flags

include $(BUILD_PACKAGE)


#
# Protocol Buffer Debug Utility in Java
#
include $(CLEAR_VARS)

LOCAL_SRC_FILES := $(call all-java-files-under, util) \
    $(call all-proto-files-under, protos)

LOCAL_PROTOC_OPTIMIZE_TYPE := nano
LOCAL_PROTOC_FLAGS := --proto_path=$(LOCAL_PATH)/protos/

LOCAL_MODULE_TAGS := optional
LOCAL_MODULE := launcher_protoutil_lib
LOCAL_IS_HOST_MODULE := true
LOCAL_JAR_MANIFEST := util/etc/manifest.txt
LOCAL_STATIC_JAVA_LIBRARIES := host-libprotobuf-java-2.3.0-nano

#include $(BUILD_HOST_JAVA_LIBRARY)

include $(CLEAR_VARS)


LOCAL_PREBUILT_STATIC_JAVA_LIBRARIES := \
    YouTubeAndroidPlayerApi:libs/YouTubeAndroidPlayerApi.jar \
    gson:libs/gson-2.2.4.jar \
    universal-image-loader:libs/universal-image-loader-1.9.5.jar \
    retrofit:libs/retrofit-1.9.0.jar \
	v7-recyclerview:libs/recyclerview-v7.jar \
	com.google.android.gms.measurement:libs/com.google.android.gms.measurement.jar \
	com.google.android.gms.analytics:libs/com.google.android.gms.analytics.jar \
	com.google.android.gms.base:libs/com.google.android.gms.base.jar \
	com.google.android.gms.gcm:libs/com.google.android.gms.gcm.jar \
	com.google.android.gms:libs/com.google.android.gms.jar \
	com.google.android.gms.location:libs/com.google.android.gms.location.jar \
	com.google.android.gms.maps:libs/com.google.android.gms.maps.jar

#    twitter-text:libs/twitter/twitter-text-1.13.0.jar

include $(BUILD_MULTI_PREBUILT)

######################## Play Service ##############################
#include $(CLEAR_VARS)
#LOCAL_MODULE := play-services-base
#LOCAL_SRC_FILES := libs/playservices/play-services-base-8.4.0.aar
#LOCAL_MODULE_CLASS := JAVA_LIBRARIES
#LOCAL_MODULE_SUFFIX := $(COMMON_JAVA_PACKAGE_SUFFIX)
#LOCAL_BUILT_MODULE_STEM := javalib.jar
#include $(BUILD_PREBUILT)
#
#include $(CLEAR_VARS)
#LOCAL_MODULE := play-services-basement
#LOCAL_SRC_FILES := libs/playservices/play-services-basement-8.4.0.aar
#LOCAL_MODULE_CLASS := JAVA_LIBRARIES
#LOCAL_MODULE_SUFFIX := $(COMMON_JAVA_PACKAGE_SUFFIX)
#LOCAL_BUILT_MODULE_STEM := javalib.jar
#include $(BUILD_PREBUILT)
#
#include $(CLEAR_VARS)
#LOCAL_MODULE := play-services-analytics
#LOCAL_SRC_FILES := libs/playservices/play-services-analytics-8.4.0.aar
#LOCAL_MODULE_CLASS := JAVA_LIBRARIES
#LOCAL_MODULE_SUFFIX := $(COMMON_JAVA_PACKAGE_SUFFIX)
#LOCAL_BUILT_MODULE_STEM := javalib.jar
#include $(BUILD_PREBUILT)
#
#include $(CLEAR_VARS)
#LOCAL_MODULE := play-services-gcm
#LOCAL_SRC_FILES := libs/playservices/play-services-gcm-8.4.0.aar
#LOCAL_MODULE_CLASS := JAVA_LIBRARIES
#LOCAL_MODULE_SUFFIX := $(COMMON_JAVA_PACKAGE_SUFFIX)
#LOCAL_BUILT_MODULE_STEM := javalib.jar
#include $(BUILD_PREBUILT)
#
#include $(CLEAR_VARS)
#LOCAL_MODULE := play-services-location
#LOCAL_SRC_FILES := libs/playservices/play-services-location-8.4.0.aar
#LOCAL_MODULE_CLASS := JAVA_LIBRARIES
#LOCAL_MODULE_SUFFIX := $(COMMON_JAVA_PACKAGE_SUFFIX)
#LOCAL_BUILT_MODULE_STEM := javalib.jar
#include $(BUILD_PREBUILT)
######################## Play Service ##############################

######################## Twitter ##############################
include $(CLEAR_VARS)
LOCAL_MODULE := twitter
LOCAL_SRC_FILES := libs/twitter/twitter-1.13.0.aar
LOCAL_MODULE_CLASS := JAVA_LIBRARIES
LOCAL_MODULE_SUFFIX := $(COMMON_JAVA_PACKAGE_SUFFIX)
LOCAL_BUILT_MODULE_STEM := javalib.jar
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := twitter-core
LOCAL_SRC_FILES := libs/twitter/twitter-core-1.6.5.aar
LOCAL_MODULE_CLASS := JAVA_LIBRARIES
LOCAL_MODULE_SUFFIX := $(COMMON_JAVA_PACKAGE_SUFFIX)
LOCAL_BUILT_MODULE_STEM := javalib.jar
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := tweet-composer
LOCAL_SRC_FILES := libs/twitter/tweet-composer-1.0.3.aar
LOCAL_MODULE_CLASS := JAVA_LIBRARIES
LOCAL_MODULE_SUFFIX := $(COMMON_JAVA_PACKAGE_SUFFIX)
LOCAL_BUILT_MODULE_STEM := javalib.jar
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := tweet-ui
LOCAL_SRC_FILES := libs/twitter/twitterui.aar
LOCAL_MODULE_CLASS := JAVA_LIBRARIES
LOCAL_MODULE_SUFFIX := $(COMMON_JAVA_PACKAGE_SUFFIX)
LOCAL_BUILT_MODULE_STEM := javalib.jar
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := twitter-unity
LOCAL_SRC_FILES := libs/twitter/twitter-unity-0.1.0.aar
LOCAL_MODULE_CLASS := JAVA_LIBRARIES
LOCAL_MODULE_SUFFIX := $(COMMON_JAVA_PACKAGE_SUFFIX)
LOCAL_BUILT_MODULE_STEM := javalib.jar
include $(BUILD_PREBUILT)
######################## Twitter ##############################

######################## Crashlytics ##############################
include $(CLEAR_VARS)
LOCAL_MODULE := answers
LOCAL_SRC_FILES := libs/crashlytics/answers-1.3.6.aar
LOCAL_MODULE_CLASS := JAVA_LIBRARIES
LOCAL_MODULE_SUFFIX := $(COMMON_JAVA_PACKAGE_SUFFIX)
LOCAL_BUILT_MODULE_STEM := javalib.jar
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := beta
LOCAL_SRC_FILES := libs/crashlytics/beta-1.1.4.aar
LOCAL_MODULE_CLASS := JAVA_LIBRARIES
LOCAL_MODULE_SUFFIX := $(COMMON_JAVA_PACKAGE_SUFFIX)
LOCAL_BUILT_MODULE_STEM := javalib.jar
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := crashlytics
LOCAL_SRC_FILES := libs/crashlytics/crashlytics-2.5.5.aar
LOCAL_MODULE_CLASS := JAVA_LIBRARIES
LOCAL_MODULE_SUFFIX := $(COMMON_JAVA_PACKAGE_SUFFIX)
LOCAL_BUILT_MODULE_STEM := javalib.jar
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := crashlytics-core
LOCAL_SRC_FILES := libs/crashlytics/crashlytics-core-2.3.8.aar
LOCAL_MODULE_CLASS := JAVA_LIBRARIES
LOCAL_MODULE_SUFFIX := $(COMMON_JAVA_PACKAGE_SUFFIX)
LOCAL_BUILT_MODULE_STEM := javalib.jar
include $(BUILD_PREBUILT)
######################## Crashlytics ##############################

######################## Fabric ##############################
include $(CLEAR_VARS)
LOCAL_MODULE := fabric
LOCAL_SRC_FILES := libs/fabric-1.3.10.aar
LOCAL_MODULE_CLASS := JAVA_LIBRARIES
LOCAL_MODULE_SUFFIX := $(COMMON_JAVA_PACKAGE_SUFFIX)
LOCAL_BUILT_MODULE_STEM := javalib.jar
include $(BUILD_PREBUILT)
######################## Fabric ##############################

######################## Digits ##############################
include $(CLEAR_VARS)
LOCAL_MODULE := digits
LOCAL_SRC_FILES := libs/digits-1.10.0.aar
LOCAL_MODULE_CLASS := JAVA_LIBRARIES
LOCAL_MODULE_SUFFIX := $(COMMON_JAVA_PACKAGE_SUFFIX)
LOCAL_BUILT_MODULE_STEM := javalib.jar
include $(BUILD_PREBUILT)
######################## Digits ##############################

#
# Protocol Buffer Debug Utility Wrapper Script
#
include $(CLEAR_VARS)
LOCAL_IS_HOST_MODULE := true
LOCAL_MODULE_CLASS := EXECUTABLES
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE := launcher_protoutil

#include $(BUILD_SYSTEM)/base_rules.mk

$(LOCAL_BUILT_MODULE): launcher_protoutil_lib
$(LOCAL_BUILT_MODULE): $(LOCAL_PATH)/util/etc/launcher_protoutil | $(ACP)
	@echo "Copy: $(PRIVATE_MODULE) ($@)"
	$(copy-file-to-new-target)
	$(hide) chmod 755 $@

INTERNAL_DALVIK_MODULES += $(LOCAL_INSTALLED_MODULE)

include $(call all-makefiles-under,$(LOCAL_PATH))
