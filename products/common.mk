# Generic product
PRODUCT_NAME := skydragon
PRODUCT_BRAND := skydragon
PRODUCT_DEVICE := generic

SKYDRAGON_BUILD_DATE := $(shell date -u +%Y%m%d-%H%M)

EXCLUDE_SYSTEMUI_TESTS := true

PRODUCT_BUILD_PROP_OVERRIDES := BUILD_DISPLAY_ID=$(TARGET_PRODUCT)-$(PLATFORM_VERSION)-$(BUILD_ID)

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    keyguard.no_require_sim=true \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.com.google.clientidbase=android-google \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.setupwizard.enterprise_mode=1 \
    ro.setupwizard.network_required=false \
    ro.setupwizard.gservices_delay=-1 \
    ro.com.android.dataroaming=false \
    drm.service.enabled=true \
    net.tethering.noprovisioning=true \
    persist.sys.dun.override=0 \
    persist.debug.wfd.enable=1 \
    persist.sys.wfd.virtual=0 \
    ro.build.selinux=1 \
    ro.adb.secure=0 \
    ro.setupwizard.rotation_locked=true \
    ro.opa.eligible_device=true \
    persist.sys.disable_rescue=true \
    ro.config.calibration_cad=/system/etc/calibration_cad.xml
    ro.boot.vendor.overlay.theme=com.skydragon.theme.accent.pumpkin;com.skydragon.theme.primary.black

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    org.skydragon.fingerprint=$(PLATFORM_VERSION)-$(BUILD_ID)-$(SKYDRAGON_BUILD_DATE)

PRODUCT_DEFAULT_PROPERTY_OVERRIDES := \
    ro.adb.secure=0 \
    ro.secure=0 \
    persist.service.adb.enable=1

# Common overlay
PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += vendor/skydragon/overlay/common
DEVICE_PACKAGE_OVERLAYS += vendor/skydragon/overlay/common

# Fix Dialer
PRODUCT_COPY_FILES +=  \
    vendor/skydragon/prebuilt/etc/sysconfig/dialer_experience.xml:system/etc/sysconfig/dialer_experience.xml

# Turbo/Battery
PRODUCT_COPY_FILES +=  \
    vendor/skydragon/prebuilt/etc/sysconfig/turbo.xml:system/etc/sysconfig/turbo.xml

# Extra Permissions
PRODUCT_COPY_FILES +=  \
    vendor/skydragon/prebuilt/etc/permissions/privapp-permissions-skydragon.xml:system/etc/permissions/privapp-permissions-skydragon.xml

# Digital Wellbeing
PRODUCT_COPY_FILES +=  \
    vendor/skydragon/prebuilt/etc/sysconfig/wellbeing-enabler.xml:system/etc/sysconfig/wellbeing-enabler.xml \
    vendor/skydragon/prebuilt/etc/permissions/privapp-permissions-wellbeing.xml:system/etc/permissions/privapp-permissions-wellbeing.xml

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Latin IME lib - gesture typing
ifeq ($(TARGET_ARCH),arm64)
PRODUCT_COPY_FILES += \
    vendor/skydragon/prebuilt/lib64/libjni_latinimegoogle.so:system/lib64/libjni_latinimegoogle.so \
    vendor/skydragon/prebuilt/lib/libjni_latinimegoogle.so:system/lib/libjni_latinimegoogle.so
else
PRODUCT_COPY_FILES += \
    vendor/skydragon/prebuilt/lib/libjni_latinimegoogle.so:system/lib/libjni_latinimegoogle.so
endif

# APN
PRODUCT_COPY_FILES += \
    vendor/skydragon/prebuilt/etc/apns-conf.xml:system/etc/apns-conf.xml

# AR
PRODUCT_COPY_FILES += \
    vendor/skydragon/prebuilt/etc/calibration_cad.xml:system/etc/calibration_cad.xml

# Additional packages
-include vendor/skydragon/products/packages.mk

# Init.d script support
PRODUCT_COPY_FILES += \
    vendor/skydragon/prebuilt/bin/sysinit:system/bin/sysinit \
    vendor/skydragon/prebuilt/etc/init/skydragon.rc:system/etc/init/skydragon.rc \
    vendor/skydragon/prebuilt/etc/init.d/00banner:system/etc/init.d/00banner

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/skydragon/prebuilt/addon.d/50-skydragon.sh:system/addon.d/50-skydragon.sh \
    vendor/skydragon/prebuilt/bin/backuptool.sh:system/bin/backuptool.sh \
    vendor/skydragon/prebuilt/bin/backuptool.functions:system/bin/backuptool.functions

# Boot animations
$(call inherit-product-if-exists, vendor/skydragon/products/bootanimation.mk)

# Theme Support
-include vendor/skydragon/products/themes.mk

# Include SDCLANG definitions if it is requested and available
ifeq ($(HOST_OS),linux)
    ifneq ($(wildcard vendor/qcom/sdclang/),)
        include vendor/skydragon/sdclang/sdclang.mk
        include vendor/skydragon/sdclang/sdllvm-lto-defs.mk
    endif
endif
