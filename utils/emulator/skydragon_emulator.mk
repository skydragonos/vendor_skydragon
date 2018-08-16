PRODUCT_COPY_FILES += \
    vendor/skydragon/utils/emulator/fstab.ranchu:vendor/etc/fstab.ranchu \
    vendor/skydragon/prebuilt/common/etc/apns-conf.xml:system/etc/apns-conf.xml

$(call inherit-product, build/target/product/sdk_x86.mk)

$(call inherit-product, vendor/skydragon/utils/emulator/common.mk)

# Override product naming for skydragon
PRODUCT_NAME := skydragon_emulator

DEVICE_PACKAGE_OVERLAYS += vendor/skydragon/utils/emulator/overlay

ALLOW_MISSING_DEPENDENCIES := true 
