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

PRODUCT_NAME := lineage_spaced
PRODUCT_DEVICE := spaced
PRODUCT_MANUFACTURER := realme
PRODUCT_BRAND := realme
PRODUCT_MODEL := RMX3286

PRODUCT_GMS_CLIENTID_BASE := android-realme

BUILD_FINGERPRINT := realme/RMX3286/RE54B4L1:13/SP1A.210812.016/R.1c05817+2a8bc:user/release-keys
