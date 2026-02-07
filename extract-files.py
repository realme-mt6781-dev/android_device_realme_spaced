#!/usr/bin/env -S PYTHONPATH=../../../tools/extract-utils python3
#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

from extract_utils.main import (
    ExtractUtils,
    ExtractUtilsModule,
)
from extract_utils.fixups_blob import (
    blob_fixup,
    blob_fixups_user_type,
)

# -----------------------------------------------------------------------------
# Namespace imports (adjust if you add shared deps later)
# -----------------------------------------------------------------------------

namespace_imports = [
    'device/realme/spaced',
    'hardware/google/interfaces',
    'hardware/google/pixel',
    'hardware/mediatek',
    'hardware/mediatek/libmtkperf_client',
    'hardware/lineage/compat',
]


def lib_fixup_odm_suffix(lib: str, partition: str, *args, **kwargs):
    return f'{lib}_{partition}' if partition == 'odm' else None


def lib_fixup_vendor_suffix(lib: str, partition: str, *args, **kwargs):
    return f'{lib}_{partition}' if partition == 'vendor' else None

lib_fixups: lib_fixups_user_type = {
    **lib_fixups,

    # ----------------
    # vendor variants
    # ----------------
    (
        'vendor.mediatek.hardware.videotelephony@1.0',
        'liboplus_platform_hwi.so',
        'vendor.oplus.hardware.radio-V1-ndk_platform.so',
    ): lib_fixup_vendor_suffix,

    # -------------
    # odm variants
    # -------------
    (
        'vendor.oplus.hardware.biometrics.fingerprint@2.1',
        'libhwm-oplus',
        'libremosaic_wrapper',
        'libremosaiclib',
        'vendor.oplus.hardware.commondcs@1.0',
        'libAlgoProcess.so',
    ): lib_fixup_odm_suffix,
}

# -----------------------------------------------------------------------------
# Blob fixups
# -----------------------------------------------------------------------------

blob_fixups: blob_fixups_user_type = {
    # Audio
    'vendor/lib*/hw/audio.primary.mt6781.so': blob_fixup()
        .replace_needed('libalsautils.so', 'libalsautils-v31.so'),

    # Base shim users
    (
        'vendor/lib*/libnvram.so',
        'vendor/lib*/libsysenv.so',
        'vendor/lib*/libtflite_mtk.so',
        'odm/bin/hw/vendor.oplus.hardware.charger@1.0-service',
        'vendor/bin/hw/android.hardware.neuralnetworks@1.3-service-mtk-neuron',
    ): blob_fixup()
        .add_needed('libbase_shim.so'),

    # Camera HAL server
    'vendor/bin/hw/camerahalserver': blob_fixup()
        .replace_needed('libutils.so', 'libutils-v32.so')
        .replace_needed('libbinder.so', 'libbinder-v32.so')
        .replace_needed('libhidlbase.so', 'libhidlbase-v32.so'),

    # Camera provider
    'vendor/lib64/hw/android.hardware.camera.provider@2.6-impl-mediatek.so': blob_fixup()
        .replace_needed('libutils.so', 'libutils-v32.so')
        .replace_needed('libbinder.so', 'libbinder-v32.so')
        .replace_needed('libhidlbase.so', 'libhidlbase-v32.so')
        .add_needed('libcamera_metadata_shim.so'),

    # PQ HAL
    'vendor/lib*/hw/vendor.mediatek.hardware.pq@2.15-impl.so': blob_fixup()
        .replace_needed('libutils.so', 'libutils-v32.so')
        .replace_needed(
            'libsensorndkbridge.so',
            'android.hardware.sensors@1.0-convert-shared.so',
        ),

    # Bluetooth rc
    'vendor/etc/init/android.hardware.bluetooth@1.1-service-mediatek.rc': blob_fixup()
        .regex_replace(r'.*vts.*\n', ''),

    # Feature policy patch
    'vendor/lib64/libmtkcam_featurepolicy.so': blob_fixup()
        .sig_replace('34 E8 87 40 B9', '34 28 02 80 52'),

    # NN service rc
    'vendor/etc/init/android.hardware.neuralnetworks@1.3-service-mtk-neuron.rc': blob_fixup()
        .regex_replace(r'\bstart\b', 'enable'),

    # Codec2
    'vendor/bin/hw/android.hardware.media.c2@1.2-mediatek-64b': blob_fixup()
        .add_needed('libstagefright_foundation-v33.so')
        .replace_needed(
            'libavservices_minijail_vendor.so',
            'libavservices_minijail.so',
        ),

    'vendor/etc/init/android.hardware.media.c2@1.2-mediatek.rc': blob_fixup()
        .regex_replace('@1.2-mediatek', '@1.2-mediatek-64b'),

    # JNI
    'lib*/libem_support_jni.so': blob_fixup()
        .add_needed('libjni_shim.so'),

    # Thermal
    'vendor/lib64/hw/android.hardware.thermal@2.0-impl.so': blob_fixup()
        .replace_needed('libutils.so', 'libutils-v32.so'),

    # Camera utils
    'vendor/lib*/libmtkcam_stdutils.so': blob_fixup()
        .replace_needed('libutils.so', 'libutils-v32.so'),

    # RIL
    'vendor/bin/hw/mtkfusionrild': blob_fixup()
        .add_needed('libutils-v32.so'),

    # Sensors bridge
    (
        'vendor/bin/mnld',
        'vendor/lib*/libaalservice.so',
        'vendor/lib64/libcam.utils.sensorprovider.so',
        'vendor/lib64/liboplus_mtkcam_lightsensorprovider.so',
        'vendor/lib64/hw/android.hardware.sensors@2.X-subhal-mediatek.so',
    ): blob_fixup()
        .replace_needed(
            'libsensorndkbridge.so',
            'android.hardware.sensors@1.0-convert-shared.so',
        ),

    # Camera libs needing liblog
    (
        'vendor/lib64/libaaa_ltm.so',
        'vendor/lib64/lib3a.flash.so',
        'vendor/lib64/lib3a.ae.stat.so',
        'vendor/lib64/lib3a.sensors.color.so',
        'vendor/lib64/lib3a.sensors.flicker.so',
        'vendor/lib64/libSQLiteModule_VER_ALL.so',
    ): blob_fixup()
        .add_needed('liblog.so'),

    # GNSS
    (
        'vendor/bin/hw/android.hardware.gnss-service.mediatek',
        'vendor/lib64/hw/android.hardware.gnss-impl-mediatek.so',
    ): blob_fixup()
        .replace_needed(
            'android.hardware.gnss-V1-ndk_platform.so',
            'android.hardware.gnss-V1-ndk.so',
        ),

    # HWComposer
    'vendor/lib64/hw/hwcomposer.mt6781.so': blob_fixup()
        .add_needed('libprocessgroup_shim.so'),

    # MNL
    'vendor/lib64/libmnl.so': blob_fixup()
        .add_needed('libcutils.so'),
}  # fmt: skip

# -----------------------------------------------------------------------------
# Module definition
# -----------------------------------------------------------------------------

module = ExtractUtilsModule(
    'spaced',
    'realme',
    namespace_imports=namespace_imports,
    blob_fixups=blob_fixups,
)

# -----------------------------------------------------------------------------
# Main
# -----------------------------------------------------------------------------

if __name__ == '__main__':
    utils = ExtractUtils.device(module)
    utils.run()
