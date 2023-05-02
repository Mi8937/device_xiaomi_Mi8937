#
# Copyright (C) 2021 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Partitions
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_PARTITION_SIZE := 536870912

# Inherit from common mithorium-common
include device/xiaomi/mithorium-common/BoardConfigCommon.mk

DEVICE_PATH := device/xiaomi/Mi8937
USES_DEVICE_XIAOMI_MI8937 := true

# Asserts
TARGET_OTA_ASSERT_DEVICE := mi8937,landtoni,land,santoni,prada,ulova,ulysse,ugglite,ugg,rova,rolex,riva,Mi8937,Mi8937_4_19

# Camera
#MI8937_CAM_USE_LATEST_CAMERA_STACK := true
MI8937_CAM_USE_RENAMED_BLOBS_L := true
MI8937_CAM_USE_RENAMED_BLOBS_P := true
MI8937_CAM_USE_RENAMED_BLOBS_U := true

# Display
TARGET_SCREEN_DENSITY := 280

# HIDL
DEVICE_MANIFEST_FILE += $(DEVICE_PATH)/manifest.xml

# Init
TARGET_INIT_VENDOR_LIB := //$(DEVICE_PATH):init_xiaomi_mi8937
TARGET_RECOVERY_DEVICE_MODULES := init_xiaomi_mi8937

# Kernel
TARGET_KERNEL_CONFIG := \
    vendor/msm8937-perf_defconfig \
    vendor/xiaomi/common.config \
    vendor/xiaomi/msm8937/common.config \
    vendor/xiaomi/msm8937/mi8937.config \
    vendor/xiaomi/feature/android-12.config \
    vendor/xiaomi/feature/lmkd.config

ifeq ($(MI8937_CAM_USE_LATEST_CAMERA_STACK),true)
TARGET_KERNEL_CONFIG += vendor/xiaomi/msm8937/optional/latest-camera-stack.config
endif

ifeq ($(TARGET_KERNEL_VERSION),4.19)
TARGET_KERNEL_SOURCE := kernel/xiaomi/msm8937-4.19
else
TARGET_KERNEL_SOURCE := kernel/xiaomi/msm8937
endif

# Partitions
BOARD_BOOTIMAGE_PARTITION_SIZE := 67108864
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 67108864
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_CACHEIMAGE_PARTITION_SIZE := 268435456
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 3221225472
BOARD_USERDATAIMAGE_PARTITION_SIZE := 10332634112 # 10332650496 - 16384

# Power
TARGET_TAP_TO_WAKE_NODE := "/proc/sys/dev/dt2w"

# Recovery
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/rootdir/etc/fstab.qcom

# Security patch level
VENDOR_SECURITY_PATCH := 2017-04-01

# SELinux
BOARD_VENDOR_SEPOLICY_DIRS += $(DEVICE_PATH)/sepolicy/vendor
BOARD_VENDOR_SEPOLICY_DIRS += $(DEVICE_PATH)/biometrics/sepolicy

# Inherit from the proprietary version
ifeq ($(TARGET_KERNEL_VERSION),4.19)
include vendor/xiaomi/Mi8937_4_19/BoardConfigVendor.mk
else
include vendor/xiaomi/Mi8937/BoardConfigVendor.mk
endif
