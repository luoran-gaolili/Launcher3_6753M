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

#Add zhaopenglin for use ori launcher 20160413(start)
ifeq ($(strip $(RGK_K_Wallpaper_SUPPORT)), no)
LOCAL_MANIFEST_FILE := ori/AndroidManifest.xml
endif
#Add zhaopenglin for use ori launcher 20160413(end)

LOCAL_MODULE_TAGS := optional

LOCAL_STATIC_JAVA_AAR_LIBRARIES := \
    play-services-base \
    play-services-basement \
    play-services-analytics \
    play-services-gcm \
    play-services-location \
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
    digits
    
LOCAL_STATIC_JAVA_LIBRARIES := \
    android-support-v4 \
    android-support-v7-recyclerview \
    YouTubeAndroidPlayerApi \
    gson \
    universal-image-loader \
    retrofit \
    com.mediatek.launcher3.ext

LOCAL_JAVA_LIBRARIES := mediatek-framework \
                        framework \
                        telephony-common \
                        mediatek-common

LOCAL_SRC_FILES := $(call all-java-files-under, src) \
    $(call all-java-files-under, WallpaperPicker/src) \
    $(call all-proto-files-under, protos)

SRC_ROOT := src/com/android/launcher3
ifeq ($(strip $(OPTR_SPEC_SEG_DEF)),OP09_SPEC0212_SEGDEFAULT)
LOCAL_SRC_FILES := $(filter-out $(SRC_ROOT)/allapps/AllAppsContainerView.java, $(LOCAL_SRC_FILES))
LOCAL_SRC_FILES := $(filter-out $(SRC_ROOT)/allapps/AllAppsGridAdapter.java, $(LOCAL_SRC_FILES))
LOCAL_SRC_FILES := $(filter-out $(SRC_ROOT)/allapps/AllAppsRecyclerView.java, $(LOCAL_SRC_FILES))
LOCAL_SRC_FILES := $(filter-out $(SRC_ROOT)/allapps/AlphabeticalAppsList.java, $(LOCAL_SRC_FILES))

LOCAL_SRC_FILES := $(filter-out $(SRC_ROOT)/AllAppsListPluginEx.java, $(LOCAL_SRC_FILES))
LOCAL_SRC_FILES := $(filter-out $(SRC_ROOT)/AppInfo.java, $(LOCAL_SRC_FILES))
LOCAL_SRC_FILES := $(filter-out $(SRC_ROOT)/BaseRecyclerViewFastScrollBar.java, $(LOCAL_SRC_FILES))
LOCAL_SRC_FILES := $(filter-out $(SRC_ROOT)/BubbleTextView.java, $(LOCAL_SRC_FILES))
LOCAL_SRC_FILES := $(filter-out $(SRC_ROOT)/CellLayout.java, $(LOCAL_SRC_FILES))
LOCAL_SRC_FILES := $(filter-out $(SRC_ROOT)/DragController.java, $(LOCAL_SRC_FILES))
LOCAL_SRC_FILES := $(filter-out $(SRC_ROOT)/Folder.java, $(LOCAL_SRC_FILES))
LOCAL_SRC_FILES := $(filter-out $(SRC_ROOT)/FolderIcon.java, $(LOCAL_SRC_FILES))
LOCAL_SRC_FILES := $(filter-out $(SRC_ROOT)/FolderInfo.java, $(LOCAL_SRC_FILES))
LOCAL_SRC_FILES := $(filter-out $(SRC_ROOT)/FolderPagedView.java, $(LOCAL_SRC_FILES))
LOCAL_SRC_FILES := $(filter-out $(SRC_ROOT)/FolderPluginEx.java, $(LOCAL_SRC_FILES))
LOCAL_SRC_FILES := $(filter-out $(SRC_ROOT)/HideAppsActivity.java, $(LOCAL_SRC_FILES))
LOCAL_SRC_FILES := $(filter-out $(SRC_ROOT)/ItemInfo.java, $(LOCAL_SRC_FILES))
LOCAL_SRC_FILES := $(filter-out $(SRC_ROOT)/Launcher.java, $(LOCAL_SRC_FILES))
LOCAL_SRC_FILES := $(filter-out $(SRC_ROOT)/LauncherExtPlugin.java, $(LOCAL_SRC_FILES))
LOCAL_SRC_FILES := $(filter-out $(SRC_ROOT)/LauncherModel.java, $(LOCAL_SRC_FILES))
LOCAL_SRC_FILES := $(filter-out $(SRC_ROOT)/LauncherModelPluginEx.java, $(LOCAL_SRC_FILES))
LOCAL_SRC_FILES := $(filter-out $(SRC_ROOT)/LauncherPluginEx.java, $(LOCAL_SRC_FILES))
LOCAL_SRC_FILES := $(filter-out $(SRC_ROOT)/LauncherProvider.java, $(LOCAL_SRC_FILES))
LOCAL_SRC_FILES := $(filter-out $(SRC_ROOT)/ShortcutInfo.java, $(LOCAL_SRC_FILES))
LOCAL_SRC_FILES := $(filter-out $(SRC_ROOT)/Workspace.java, $(LOCAL_SRC_FILES))

LOCAL_SRC_FILES += $(call all-java-files-under, $(SRC_ROOT)/op09)
else
OP09_SRC := $(call all-java-files-under, $(SRC_ROOT)/op09)
LOCAL_SRC_FILES := $(filter-out $(OP09_SRC), $(LOCAL_SRC_FILES))
endif

LOCAL_RESOURCE_DIR := $(LOCAL_PATH)/WallpaperPicker/res \
    $(LOCAL_PATH)/res \
    $(LOCAL_PATH)/../../../prebuilts/sdk/current/support/v7/recyclerview/res

LOCAL_PROGUARD_FLAG_FILES := proguard.flags

LOCAL_PROTOC_OPTIMIZE_TYPE := nano
LOCAL_PROTOC_FLAGS := --proto_path=$(LOCAL_PATH)/protos/
LOCAL_AAPT_FLAGS := \
    --auto-add-overlay \
    --extra-packages android.support.v7.recyclerview

#LOCAL_SDK_VERSION := current
LOCAL_PACKAGE_NAME := Launcher3WithLefty
LOCAL_PRIVILEGED_MODULE := true
LOCAL_CERTIFICATE := shared

LOCAL_OVERRIDES_PACKAGES := Home Launcher2 Launcher3

include $(BUILD_PACKAGE)

include $(CLEAR_VARS)


LOCAL_PREBUILT_STATIC_JAVA_LIBRARIES := \
    YouTubeAndroidPlayerApi:libs/YouTubeAndroidPlayerApi.jar \
    gson:libs/gson-2.2.4.jar \
    universal-image-loader:libs/universal-image-loader-1.9.5.jar \
    retrofit:libs/retrofit-1.9.0.jar
    
include $(BUILD_MULTI_PREBUILT)

######################## Play Service ##############################
include $(CLEAR_VARS)
LOCAL_MODULE := play-services-base
LOCAL_SRC_FILES := libs/play-services-base-8.4.0.aar
LOCAL_MODULE_CLASS := JAVA_LIBRARIES
LOCAL_MODULE_SUFFIX := $(COMMON_JAVA_PACKAGE_SUFFIX)
LOCAL_BUILT_MODULE_STEM := javalib.jar
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := play-services-basement
LOCAL_SRC_FILES := libs/play-services-basement-8.4.0.aar
LOCAL_MODULE_CLASS := JAVA_LIBRARIES
LOCAL_MODULE_SUFFIX := $(COMMON_JAVA_PACKAGE_SUFFIX)
LOCAL_BUILT_MODULE_STEM := javalib.jar
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := play-services-analytics
LOCAL_SRC_FILES := libs/play-services-analytics-8.4.0.aar
LOCAL_MODULE_CLASS := JAVA_LIBRARIES
LOCAL_MODULE_SUFFIX := $(COMMON_JAVA_PACKAGE_SUFFIX)
LOCAL_BUILT_MODULE_STEM := javalib.jar
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := play-services-gcm
LOCAL_SRC_FILES := libs/play-services-gcm-8.4.0.aar
LOCAL_MODULE_CLASS := JAVA_LIBRARIES
LOCAL_MODULE_SUFFIX := $(COMMON_JAVA_PACKAGE_SUFFIX)
LOCAL_BUILT_MODULE_STEM := javalib.jar
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := play-services-location
LOCAL_SRC_FILES := libs/play-services-location-8.4.0.aar
LOCAL_MODULE_CLASS := JAVA_LIBRARIES
LOCAL_MODULE_SUFFIX := $(COMMON_JAVA_PACKAGE_SUFFIX)
LOCAL_BUILT_MODULE_STEM := javalib.jar
include $(BUILD_PREBUILT)
######################## Play Service ##############################

######################## Twitter ##############################
include $(CLEAR_VARS)
LOCAL_MODULE := twitter
LOCAL_SRC_FILES := libs/twitter-1.13.0.aar
LOCAL_MODULE_CLASS := JAVA_LIBRARIES
LOCAL_MODULE_SUFFIX := $(COMMON_JAVA_PACKAGE_SUFFIX)
LOCAL_BUILT_MODULE_STEM := javalib.jar
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := twitter-core
LOCAL_SRC_FILES := libs/twitter-core-1.6.5.aar
LOCAL_MODULE_CLASS := JAVA_LIBRARIES
LOCAL_MODULE_SUFFIX := $(COMMON_JAVA_PACKAGE_SUFFIX)
LOCAL_BUILT_MODULE_STEM := javalib.jar
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := tweet-composer
LOCAL_SRC_FILES := libs/tweet-composer-1.0.3.aar
LOCAL_MODULE_CLASS := JAVA_LIBRARIES
LOCAL_MODULE_SUFFIX := $(COMMON_JAVA_PACKAGE_SUFFIX)
LOCAL_BUILT_MODULE_STEM := javalib.jar
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := tweet-ui
LOCAL_SRC_FILES := libs/twitterui.aar
LOCAL_MODULE_CLASS := JAVA_LIBRARIES
LOCAL_MODULE_SUFFIX := $(COMMON_JAVA_PACKAGE_SUFFIX)
LOCAL_BUILT_MODULE_STEM := javalib.jar
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := twitter-unity
LOCAL_SRC_FILES := libs/twitter-unity-0.1.0.aar
LOCAL_MODULE_CLASS := JAVA_LIBRARIES
LOCAL_MODULE_SUFFIX := $(COMMON_JAVA_PACKAGE_SUFFIX)
LOCAL_BUILT_MODULE_STEM := javalib.jar
include $(BUILD_PREBUILT)
######################## Twitter ##############################

######################## Crashlytics ##############################
include $(CLEAR_VARS)
LOCAL_MODULE := answers
LOCAL_SRC_FILES := libs/answers-1.3.6.aar
LOCAL_MODULE_CLASS := JAVA_LIBRARIES
LOCAL_MODULE_SUFFIX := $(COMMON_JAVA_PACKAGE_SUFFIX)
LOCAL_BUILT_MODULE_STEM := javalib.jar
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := beta
LOCAL_SRC_FILES := libs/beta-1.1.4.aar
LOCAL_MODULE_CLASS := JAVA_LIBRARIES
LOCAL_MODULE_SUFFIX := $(COMMON_JAVA_PACKAGE_SUFFIX)
LOCAL_BUILT_MODULE_STEM := javalib.jar
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := crashlytics
LOCAL_SRC_FILES := libs/crashlytics-2.5.5.aar
LOCAL_MODULE_CLASS := JAVA_LIBRARIES
LOCAL_MODULE_SUFFIX := $(COMMON_JAVA_PACKAGE_SUFFIX)
LOCAL_BUILT_MODULE_STEM := javalib.jar
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := crashlytics-core
LOCAL_SRC_FILES := libs/crashlytics-core-2.3.8.aar
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

include $(BUILD_HOST_JAVA_LIBRARY)

#
# Protocol Buffer Debug Utility Wrapper Script
#
include $(CLEAR_VARS)
LOCAL_IS_HOST_MODULE := true
LOCAL_MODULE_CLASS := EXECUTABLES
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE := launcher_protoutil

include $(BUILD_SYSTEM)/base_rules.mk

$(LOCAL_BUILT_MODULE): | $(HOST_OUT_JAVA_LIBRARIES)/launcher_protoutil_lib.jar
$(LOCAL_BUILT_MODULE): $(LOCAL_PATH)/util/etc/launcher_protoutil | $(ACP)
	@echo "Copy: $(PRIVATE_MODULE) ($@)"
	$(copy-file-to-new-target)
	$(hide) chmod 755 $@

INTERNAL_DALVIK_MODULES += $(LOCAL_INSTALLED_MODULE)

include $(call all-makefiles-under,$(LOCAL_PATH))