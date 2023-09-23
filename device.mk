#
# Copyright (C) 2022 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Installs gsi keys into ramdisk, to boot a developer GSI with verified boot.
$(call inherit-product, $(SRC_TARGET_DIR)/product/developer_gsi_keys.mk)

# Enable updating of APEXes
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)

# Shipping API level
PRODUCT_SHIPPING_API_LEVEL := 30

# Audio
PRODUCT_PACKAGES += \
    android.hardware.audio.service \
    android.hardware.audio@6.0-impl \
    android.hardware.audio@7.0-impl \
    android.hardware.audio.effect@7.0-impl \
    android.hardware.audio.effect@6.0-impl \
    android.hardware.audio.common-util.vendor \
    android.hardware.audio.common@5.0.vendor \
    android.hardware.audio.common@6.0.vendor \
    android.hardware.audio.common@6.0-util.vendor \
    android.hardware.audio.common@7.0.vendor \
    android.hardware.audio.common@7.0-util.vendor \
    android.hardware.audio@6.0.vendor \
    android.hardware.audio@6.0-util.vendor \
    android.hardware.audio@7.0-util.vendor \
    android.hardware.audio@7.0.vendor \
    audio.bluetooth.default \
    libaudiofoundation.vendor \
    libbluetooth_audio_session \
    libalsautils \
    libnbaio_mono \
    libtinycompress \
    libdynproc \
    libhapticgenerator \
    audio.r_submix.default \
    audio.usb.default \
    audio_policy.stub

# Bluetooth
PRODUCT_PACKAGES += \
    android.hardware.bluetooth@1.0.vendor \
    android.hardware.bluetooth@1.1.vendor

# Camera
PRODUCT_PACKAGES += \
    android.hardware.camera.common@1.0.vendor \
    android.hardware.camera.device@3.2.vendor \
    android.hardware.camera.device@1.0.vendor \
    android.hardware.camera.device@3.3.vendor \
    android.hardware.camera.device@3.4.vendor \
    android.hardware.camera.device@3.5.vendor \
    android.hardware.camera.device@3.6.vendor \
    android.hardware.camera.provider@2.4.vendor \
    android.hardware.camera.provider@2.5.vendor \
    android.hardware.camera.provider@2.6.vendor \
    libcamera2ndk_vendor

# Display
PRODUCT_PACKAGES += \
    android.hardware.graphics.allocator@2.0.vendor \
    android.hardware.graphics.allocator@3.0.vendor \
    android.hardware.graphics.allocator@4.0.vendor \
    android.hidl.allocator@1.0.vendor \
    android.hardware.graphics.common-V2-ndk_platform.vendor \
    android.hardware.graphics.composer@2.1-resources.vendor \
    android.hardware.graphics.composer@2.2-resources.vendor \
    android.hardware.graphics.composer@2.3-service \
    android.hardware.memtrack@1.0-service \
    android.hardware.memtrack@1.0-impl \
    libdrm.vendor

# DRM
PRODUCT_PACKAGES += \
    android.hardware.drm@1.0.vendor \
    android.hardware.drm@1.1.vendor \
    android.hardware.drm@1.2.vendor \
    android.hardware.drm@1.3.vendor \
    android.hardware.drm@1.4.vendor

# fastbootd
PRODUCT_PACKAGES += \
    fastbootd

# Gatekeeper
PRODUCT_PACKAGES += \
    android.hardware.gatekeeper@1.0-service \
    android.hardware.gatekeeper@1.0-impl

# GNSS
PRODUCT_PACKAGES += \
    android.hardware.gnss.measurement_corrections@1.0.vendor \
    android.hardware.gnss.measurement_corrections@1.1.vendor \
    android.hardware.gnss.visibility_control@1.0.vendor \
    android.hardware.gnss@1.0.vendor \
    android.hardware.gnss@1.1.vendor \
    android.hardware.gnss@2.0.vendor \
    android.hardware.gnss@2.1.vendor \
    android.hardware.gnss-V1-ndk.vendor

# Health
PRODUCT_PACKAGES += \
    android.hardware.health@2.1-impl \
    android.hardware.health@2.1-impl.recovery \
    android.hardware.health@2.1-service

# HIDL
PRODUCT_PACKAGES += \
    libhidltransport \
    libhidltransport.vendor \
    libhardware \
    libhardware.vendor \
    libhwbinder \
    libhwbinder.vendor

# Keymaster
PRODUCT_PACKAGES += \
   android.hardware.keymaster-V3-ndk_platform.vendor \
   android.hardware.keymaster@3.0.vendor \
   android.hardware.keymaster@4.0.vendor \
   android.hardware.keymaster@4.1.vendor \
   libkeymaster4.vendor:64 \
   libkeymaster4support.vendor:64 \
   libkeymaster4_1support.vendor:64 \
   libkeymaster41.vendor:64 \
   libkeymaster_messages.vendor:64 \
   libkeymaster_portable.vendor:64 \
   libpuresoftkeymasterdevice.vendor:64 \
   libsoft_attestation_cert.vendor:64 \
   libkeystore-wifi-hidl \
   libkeystore-engine-wifi-hidl

# Lights
PRODUCT_PACKAGES += \
    android.hardware.light-service.spaced

# Media
PRODUCT_PACKAGES += \
    libcodec2_hidl@1.1.vendor \
    libcodec2_hidl@1.2.vendor \
    libavservices_minijail_vendor \
    libstagefright_softomx_plugin.vendor \
    libsfplugin_ccodec_utils.vendor \
    libcodec2_soft_common.vendor

# Overlays
PRODUCT_ENFORCE_RRO_TARGETS := *

# Power
PRODUCT_PACKAGES += \
    android.hardware.power@1.0.vendor \
    android.hardware.power@1.1.vendor \
    android.hardware.power@1.2.vendor \
    android.hardware.power-V2-ndk_platform.vendor

# Radio
PRODUCT_PACKAGES += \
    android.hardware.radio.config@1.0.vendor \
    android.hardware.radio.config@1.1.vendor \
    android.hardware.radio.config@1.2.vendor \
    android.hardware.radio.config@1.3.vendor \
    android.hardware.radio@1.0.vendor \
    android.hardware.radio@1.1.vendor \
    android.hardware.radio@1.2.vendor \
    android.hardware.radio@1.3.vendor \
    android.hardware.radio@1.4.vendor \
    android.hardware.radio@1.5.vendor \
    android.hardware.radio@1.6.vendor

# RCS 
PRODUCT_PACKAGES += \
    com.android.ims.rcsmanager \
    RcsService \
    PresencePolling

# RenderScript
PRODUCT_PACKAGES += \
    android.hardware.renderscript@1.0-imp

# Rootdir
PRODUCT_PACKAGES += \
    fstab.mt6781 \
    init.ago.rc \
    init.cgroup.rc \
    init.connectivity.common.rc \
    init.connectivity.rc \
    init_connectivity.rc \
    init.modem.rc \
    init.mt6781.rc \
    init.mt6781.usb.rc \
    init.project.rc \
    init.sensor_1_0.rc \
    ueventd.mtk.rc \
    ueventd.oplus.rc

# Sensors
PRODUCT_PACKAGES += \
    android.frameworks.sensorservice@1.0 \
    android.hardware.sensors@2.0 \
    android.hardware.sensors@2.0.vendor \
    android.hardware.sensors@2.0-ScopedWakelock.vendor \
    android.hardware.sensors@2.1

PRODUCT_PACKAGES += \
    libsensorndkbridge

# Soundtrigger
PRODUCT_PACKAGES += \
    android.hardware.soundtrigger@2.3-impl

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# Inherit the proprietary files
$(call inherit-product, vendor/realme/spaced/spaced-vendor.mk)