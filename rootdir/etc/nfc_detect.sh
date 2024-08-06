#!/vendor/bin/sh
#
# SPDX-FileCopyrightText: 2024 The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

if [ $(cat /proc/oplus_nfc/chipset) != "NULL" ]; then
    setprop ro.boot.product.vendor.sku nfc
fi
