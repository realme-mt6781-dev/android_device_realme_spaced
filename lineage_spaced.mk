#
# Copyright (C) 2022 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from device makefile.
$(call inherit-product, device/realme/spaced/device.mk)

# Inherit some common LineageOS stuff.
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Axion Stuff
PRODUCT_NO_CAMERA := false
AXION_CAMERA_REAR_INFO := 50,2,2
AXION_CAMERA_FRONT_INFO := 16
AXION_MAINTAINER := HELLINFIX
AXION_PROCESSOR := MTK_Helio_G96

# Axion Optional Flags
TARGET_ENABLE_BLUR := true
PERF_ANIM_OVERRIDE := true
TARGET_USES_SLMK := true
TARGET_INCLUDES_LOS_PREBUILTS := false

# Boot animation
TARGET_BOOT_ANIMATION_RES := 1080

PRODUCT_NAME := lineage_spaced
PRODUCT_DEVICE := spaced
PRODUCT_MANUFACTURER := realme
PRODUCT_BRAND := realme
PRODUCT_MODEL := RMX3286

PRODUCT_GMS_CLIENTID_BASE := android-realme

BUILD_FINGERPRINT := realme/RMX3286/RE54B4L1:13/SP1A.210812.016/R.1c05817+2a8bc:user/release-keys
