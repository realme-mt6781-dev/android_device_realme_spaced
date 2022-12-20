#
# Copyright (C) 2022 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from device makefile.
$(call inherit-product, device/realme/spaced/device.mk)

# Inherit some common LineageOS stuff.
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

PRODUCT_NAME := lineage_spaced
PRODUCT_DEVICE := spaced
PRODUCT_MANUFACTURER := Realme
PRODUCT_BRAND := Realme
PRODUCT_MODEL := Realme 8i

PRODUCT_GMS_CLIENTID_BASE := android-realme

PRODUCT_BUILD_PROP_OVERRIDES += \
    TARGET_DEVICE=RMX3151L1 \
    PRODUCT_NAME=RMX3151 \
    PRIVATE_BUILD_DESC="RMX3151-user 13 SP1A.210812.016 R.125b34c-1 release-keys"

BUILD_FINGERPRINT := realme/RMX3151/RE54B4L1:13/SP1A.210812.016/R.125b34c-1:user/release-keys