#!/bin/bash
#
# Copyright (C) 2016 The CyanogenMod Project
# Copyright (C) 2017-2020 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

set -e

DEVICE=spaced
VENDOR=realme

# Load extract_utils and do some sanity checks
MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "${MY_DIR}" ]]; then MY_DIR="${PWD}"; fi

ANDROID_ROOT="${MY_DIR}/../../.."

export TARGET_ENABLE_CHECKELF=true

export PATCHELF_VERSION=0_17_2

HELPER="${ANDROID_ROOT}/tools/extract-utils/extract_utils.sh"
if [ ! -f "${HELPER}" ]; then
    echo "Unable to find helper script at ${HELPER}"
    exit 1
fi
source "${HELPER}"

# Default to sanitizing the vendor folder before extraction
CLEAN_VENDOR=true

KANG=
SECTION=

while [ "${#}" -gt 0 ]; do
sed -i -E '/^[^#[:space:]]/ s|;?DISABLE_DEPS||g; /^[^#[:space:]]/ { /[.]apk/! s|([^;|[:space:]]+)(\|.*)?|\1;DISABLE_DEPS\2| }' "${MY_DIR}/proprietary-files.txt"
    case "${1}" in
        -n | --no-cleanup )
                CLEAN_VENDOR=false
                ;;
        -k | --kang )
                KANG="--kang"
                ;;
        -s | --section )
                SECTION="${2}"; shift
                CLEAN_VENDOR=false
                ;;
        * )
                SRC="${1}"
                ;;
    esac
    shift
done

function blob_fixup {
    case "$1" in
        vendor/lib*/hw/audio.primary.mt6781.so)
             "${PATCHELF}" --replace-needed "libalsautils.so" "libalsautils-v31.so" "${2}"
             ;;
        vendor/bin/hw/android.hardware.neuralnetworks@1.3-service-mtk-neuron|odm/bin/hw/vendor.oplus.hardware.charger@1.0-service|vendor/lib*/libnvram.so|vendor/lib*/libsysenv.so)
            [ "$2" = "" ] && return 0
            grep -q "libbase_shim.so" "${2}" || "${PATCHELF}" --add-needed "libbase_shim.so" "${2}"
            ;;
        vendor/bin/hw/camerahalserver|\
        vendor/lib64/hw/android.hardware.camera.provider@2.6-impl-mediatek.so)
            [ "$2" = "" ] && return 0
            "${PATCHELF}" --replace-needed "libutils.so" "libutils-v32.so" "${2}"
            "${PATCHELF}" --replace-needed "libbinder.so" "libbinder-v32.so" "${2}"
            "${PATCHELF}" --replace-needed "libhidlbase.so" "libhidlbase_v32.so" "${2}"
            ;;
        vendor/lib64/hw/android.hardware.camera.provider@2.6-impl-mediatek.so)
            [ "$2" = "" ] && return 0
            grep -q "libcamera_metadata_shim.so" "${2}" || "${PATCHELF}" --add-needed "libcamera_metadata_shim.so" "${2}"
            ;;
        vendor/lib*/hw/vendor.mediatek.hardware.pq@2.15-impl.so)
            "${PATCHELF}" --replace-needed "libutils.so" "libutils-v32.so" "${2}"
            "${PATCHELF}" --replace-needed "libsensorndkbridge.so" "android.hardware.sensors@1.0-convert-shared.so" "${2}"
            ;;
        vendor/etc/init/android.hardware.bluetooth@1.1-service-mediatek.rc)
            sed -i '/vts/Q' "$2"
            ;;
        vendor/lib64/libmtkcam_featurepolicy.so)
            # evaluateCaptureConfiguration()
            xxd -p "${2}" | sed "s/90b0034e88740b9/90b003428028052/g" | xxd -r -p > "${2}".patched
            mv "${2}".patched "${2}"
            ;;
        vendor/etc/init/android.hardware.neuralnetworks@1.3-service-mtk-neuron.rc)
            sed -i 's/start/enable/' "$2"
            ;;
        vendor/bin/hw/android.hardware.media.c2@1.2-mediatek|vendor/bin/hw/android.hardware.media.c2@1.2-mediatek-64b)
            "${PATCHELF}" --add-needed "libstagefright_foundation-v33.so" "${2}"
            "${PATCHELF}" --replace-needed "libavservices_minijail_vendor.so" "libavservices_minijail.so" "${2}"
            ;;
        lib64/libem_support_jni.so)
            "${PATCHELF}" --add-needed "libjni_shim.so" "${2}"
            ;;
        vendor/lib64/hw/android.hardware.thermal@2.0-impl.so)
            "${PATCHELF}" --replace-needed "libutils.so" "libutils-v32.so" "${2}"
            ;;
        vendor/lib*/libmtkcam_stdutils.so)
            "${PATCHELF}" --replace-needed "libutils.so" "libutils-v32.so" "$2"
            ;;
        vendor/bin/hw/mtkfusionrild)
        "${PATCHELF}" --add-needed "libutils-v32.so" "${2}"
            ;;
        vendor/bin/mnld|\
        vendor/lib64/libaalservice.so|\
        vendor/lib64/libcam.utils.sensorprovider.so|\
        vendor/lib64/liboplus_mtkcam_lightsensorprovider.so|\
        vendor/lib64/hw/android.hardware.sensors@2.X-subhal-mediatek.so)
           "${PATCHELF}" --replace-needed "libsensorndkbridge.so" "android.hardware.sensors@1.0-convert-shared.so" "${2}"
            ;;
        vendor/lib64/libSQLiteModule_VER_ALL.so|vendor/lib64/lib3a.flash.so)
            [ "$2" = "" ] && return 0
            grep -q "liblog.so" "${2}" || "${PATCHELF_0_17_2}" --add-needed "liblog.so" "${2}"
            ;;
        vendor/lib64/libmnl.so)
            [ "$2" = "" ] && return 0
            grep -q "libcutils.so" "${2}" || "${PATCHELF}" --add-needed "libcutils.so" "${2}"
            ;;
        vendor/lib64/hw/hwcomposer.mt6781.so)
             grep -q "libprocessgroup_shim.so" "${2}" || "${PATCHELF}" --add-needed "libprocessgroup_shim.so" "${2}"
            ;;
        vendor/bin/hw/android.hardware.gnss-service.mediatek|\
        vendor/lib64/hw/android.hardware.gnss-impl-mediatek.so)
            [ "$2" = "" ] && return 0
            "${PATCHELF}" --replace-needed "android.hardware.gnss-V1-ndk_platform.so" "android.hardware.gnss-V1-ndk.so" "${2}"
            ;;
    esac
}

if [ -z "${SRC}" ]; then
    SRC="adb"
fi

# Initialize the helper
setup_vendor "${DEVICE}" "${VENDOR}" "${ANDROID_ROOT}" false "${CLEAN_VENDOR}"

extract "${MY_DIR}/proprietary-files.txt" "${SRC}" "${KANG}" --section "${SECTION}"

bash "${MY_DIR}/setup-makefiles.sh"

sed -i -E 's|;?DISABLE_DEPS||g' "${MY_DIR}/proprietary-files.txt"
