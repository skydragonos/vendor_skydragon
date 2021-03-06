PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.build.selinux=1

# Disable excessive dalvik debug messages
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    dalvik.vm.debug.alloc=0

# Default sounds
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.config.notification_sound=Argon.ogg \
    ro.config.alarm_alert=Hassium.ogg

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/skydragon/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/skydragon/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/skydragon/prebuilt/common/bin/50-skydragon.sh:$(TARGET_COPY_OUT_SYSTEM)/addon.d/50-slim.sh

ifneq ($(AB_OTA_PARTITIONS),)
PRODUCT_COPY_FILES += \
    vendor/skydragon/prebuilt/common/bin/backuptool_ab.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.sh \
    vendor/skydragon/prebuilt/common/bin/backuptool_ab.functions:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.functions \
    vendor/skydragon/prebuilt/common/bin/backuptool_postinstall.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_postinstall.sh
endif

# DRAGON-specific init file
PRODUCT_COPY_FILES += \
    vendor/skydragon/prebuilt/common/etc/init.skydragon.rc:$(TARGET_COPY_OUT_SYSTEM)/etc/init/init.slim.rc

# Copy over added mimetype supported in libcore.net.MimeUtils
PRODUCT_COPY_FILES += \
    vendor/skydragon/prebuilt/common/lib/content-types.properties:$(TARGET_COPY_OUT_SYSTEM)/lib/content-types.properties

# Backup Services whitelist
PRODUCT_COPY_FILES += \
    vendor/skydragon/config/permissions/backup.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/backup.xml

# Enable Android Beam on all targets
PRODUCT_COPY_FILES += \
    vendor/skydragon/config/permissions/android.software.nfc.beam.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.software.nfc.beam.xml

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.software.sip.voip.xml

# Don't export PS1 in /system/etc/mkshrc.
PRODUCT_COPY_FILES += \
    vendor/skydragon/prebuilt/common/etc/mkshrc:$(TARGET_COPY_OUT_SYSTEM)/etc/mkshrc \
    vendor/skydragon/prebuilt/common/etc/sysctl.conf:$(TARGET_COPY_OUT_SYSTEM)/etc/sysctl.conf

# Include AOSP audio files
include vendor/skydragon/config/aosp_audio.mk

# TWRP
ifeq ($(WITH_TWRP),true)
include skydragon/slim/config/twrp.mk
endif

# Do not include art debug targets
PRODUCT_ART_TARGET_INCLUDE_DEBUG_BUILD := false

# Strip the local variable table and the local variable type table to reduce
# the size of the system image. This has no bearing on stack traces, but will
# leave less information available via JDWP.
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO := true

# Disable vendor restrictions
PRODUCT_RESTRICT_VENDOR_FILES := false

# Extra Optional packages
PRODUCT_PACKAGES += \
    bootanimation.zip \
    SlimLauncher \
    SlimWallpaperResizer \
    SlimWallpapers \
    LatinIME \
    BluetoothExt \
    WallpaperPicker
#    SlimFileManager removed until updated

#ifneq ($(DISABLE_SLIM_FRAMEWORK), true)
## Slim Framework
#include frameworks/slim/slim_framework.mk
#endif

## Don't compile SystemUITests
EXCLUDE_SYSTEMUI_TESTS := true

# Extra tools
PRODUCT_PACKAGES += \
    e2fsck \
    mke2fs \
    tune2fs \
    mkfs.ntfs \
    fsck.ntfs \
    mount.ntfs \
    fsck.exfat \
    mkfs.exfat

PRODUCT_PACKAGES += \
    curl \
    vim \
    wget

PRODUCT_PACKAGE_OVERLAYS += \
    vendor/skydragon/overlay/common \
    vendor/skydragon/overlay/dictionaries

PRODUCT_COPY_FILES += \
    vendor/skydragon/config/permissions/privapp-permissions-skydragon.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-skydragon.xml \
    vendor/skydragon/config/permissions/privapp-permissions-skydragon-legacy.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-skydragon-legacy.xml

EXTENDED_POST_PROCESS_PROPS := vendor/skydragon/tools/skydragon_process_props.py

PRODUCT_EXTRA_RECOVERY_KEYS += \
  vendor/skydragon/build/target/product/security/skydragon

-include vendor/skydragon-priv/keys/keys.mk

$(call inherit-product-if-exists, vendor/extra/product.mk)
