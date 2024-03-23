#
# Copyright (C) 2022 The LineageOS Project
# Copyright (C) 2023 The CipherOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from device makefile.
$(call inherit-product, device/realme/spaced/device.mk)

# Inherit some common CipherOS stuff.
$(call inherit-product, vendor/cipher/config/common_full_phone.mk)

# CipherOS specific flags
# Bootanimation res
TARGET_BOOT_ANIMATION_RES := 1080
# Faceunlock Support
TARGET_FACE_UNLOCK_SUPPORTED := true
# Maintainer
CIPHER_MAINTAINER := HELLINFIX

PRODUCT_NAME := cipher_spaced
PRODUCT_DEVICE := spaced
PRODUCT_MANUFACTURER := Realme
PRODUCT_BRAND := Realme
PRODUCT_MODEL := Realme 8i

PRODUCT_GMS_CLIENTID_BASE := android-realme

PRODUCT_BUILD_PROP_OVERRIDES += \
    TARGET_DEVICE=RMX3151L1 \
    PRODUCT_NAME=RMX3151 \
    PRIVATE_BUILD_DESC="RMX3151-user 13 SP1A.210812.016 R.1579e4a+5b86 release-keys"

BUILD_FINGERPRINT := realme/RMX3151/RE54B4L1:13/SP1A.210812.016/R.1579e4a+5b86:user/release-keys
