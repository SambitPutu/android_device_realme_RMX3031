#
# Copyright (C) 2020 Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

DEVICE_PATH := device/realme/RMX3031

# Installs gsi keys into ramdisk, to boot a GSI with verified boot.
$(call inherit-product, $(SRC_TARGET_DIR)/product/gsi_keys.mk)

# APEX
TARGET_FLATTEN_APEX := true

# VNDK
PRODUCT_EXTRA_VNDK_VERSIONS := 30

PRODUCT_SHIPPING_API_LEVEL := 30

# Call proprietary blob setup
$(call inherit-product, vendor/realme/RMX3031/RMX3031-vendor.mk)
$(call inherit-product, vendor/realme/IMS-RMX3031/mtk-ims.mk)

# Dynamic Partition
PRODUCT_USE_DYNAMIC_PARTITIONS := true
PRODUCT_BUILD_SUPER_PARTITION := false

# Boot animation
TARGET_SCREEN_HEIGHT := 2400
TARGET_SCREEN_WIDTH := 1080

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/prebuilt/bootanimation.zip:$(TARGET_COPY_OUT_PRODUCT)/media/bootanimation.zip

# A/B
AB_OTA_UPDATER := false

# Audio
PRODUCT_PACKAGES += \
    audio.a2dp.default
	
# CameraGo	
PRODUCT_PACKAGES += \
    CameraGo

PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/configs/permissions/privapp-permissions-camera-go.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/privapp-permissions-camera-go.xml

# Dex/ART optimization
PRODUCT_ART_TARGET_INCLUDE_DEBUG_BUILD := false
PRODUCT_DEX_PREOPT_DEFAULT_COMPILER_FILTER := everything
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO := true
USE_DEX2OAT_DEBUG := false

# fastbootd
PRODUCT_PACKAGES += \
    fastbootd

PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/vendor_overlay/etc/fstab.mt6893:$(TARGET_COPY_OUT_RAMDISK)/fstab.mt6893

# Fingerprint
PRODUCT_PACKAGES += \
    android.hardware.biometrics.fingerprint@2.3-service.RMX3031 \
	vendor.oplus.hardware.biometrics.fingerprint@2.1

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.fingerprint.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.fingerprint.xml

# HIDL
PRODUCT_PACKAGES += \
    libhidltransport \
    libhardware \
    libhwbinder

# ImsInit hack
PRODUCT_PACKAGES += \
    ImsInit

# Init
PRODUCT_PACKAGES += \
    init.mt6893.rc

# Keylayout
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/keylayout/touchpanel.kl:$(TARGET_COPY_OUT_SYSTEM)/usr/keylayout/touchpanel.kl

# Screen density
PRODUCT_AAPT_CONFIG := xxxhdpi
PRODUCT_AAPT_PREF_CONFIG := xxxhdpi

# Lights
PRODUCT_PACKAGES += \
    android.hardware.light@2.0-service.RMX3031 \
    android.hardware.sensors@2.0-service.multihal

# NFC
PRODUCT_PACKAGES += \
    NfcNci \
    com.android.nfc_extras \
    com.gsma.services.nfc \
    com.nxp.nfc.nq \
    libnqnfc_nci_jni \
    nfc_nci.nqx.default.hw \
    NQNfcNci \
    nqnfcee_access.xml \
    nqnfcse_access.xml \
    Tag \
    SecureElement \
    vendor.nxp.hardware.nfc@1.1-service

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/nfc/libnfc-nxp.conf:$(TARGET_COPY_OUT_SYSTEM)/etc/libnfc-nxp.conf

# Oneplus FileManager
PRODUCT_PACKAGES += \
    OPFiles
	
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/OPFiles/privapp-permissions-op-files.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/privapp-permissions-op-files.xml \

# Overlays
PRODUCT_PACKAGES += \
    FrameworkResOverlay \
    SystemUIOverlay \
	SettingsOverlay \
	TelephonyOverlay

# Enforce RRO targets
PRODUCT_ENFORCE_RRO_TARGETS := *
	
# MTK IMS Overlays
PRODUCT_PACKAGES += \
    mtk-ims \
    mtk-ims-telephony

# Permissions
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/configs/permissions/privapp-permissions-mediatek.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-mediatek.xml

# RcsService
PRODUCT_PACKAGES += \
    com.android.ims.rcsmanager \
    RcsService \
    PresencePolling

# RealmeParts
PRODUCT_PACKAGES += \
    RealmeParts \
	parts.rc

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(DEVICE_PATH)

# System prop
-include $(DEVICE_PATH)/system_prop.mk
PRODUCT_COMPATIBLE_PROPERTY_OVERRIDE := true

# Vendor overlay
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/vendor_overlay/,$(TARGET_COPY_OUT_PRODUCT)/vendor_overlay/30/)

# Wi-Fi
PRODUCT_PACKAGES += \
    TetheringConfigOverlay \
    WifiOverlay
