PRODUCT_BRAND ?= Sigma

# Cloned app exemption
PRODUCT_COPY_FILES += \
    vendor/lineage/prebuilt/common/etc/sysconfig/preinstalled-packages-platform-sigma-product.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/sysconfig/preinstalled-packages-platform-sigma-product.xml

ifeq ($(TARGET_INCLUDE_MATLOG),true)
PRODUCT_PACKAGES += \
    MatLog
endif

# Privapp-permissions whitelist mode
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.control_privapp_permissions=log

TARGET_SUPPORTS_QUICK_TAP ?= false
ifeq ($(TARGET_SUPPORTS_QUICK_TAP), true)
PRODUCT_PRODUCT_PROPERTIES += \
    persist.columbus.use_ap_sensor=false
endif

# RRO Packages
PRODUCT_PACKAGES += \
    AndroidOverlay \
    Launcher3Overlay

# Launcher3 as Default Launcher
PRODUCT_SYSTEM_PROPERTIES += \
    persist.sys.default_launcher=0 \
    persist.sys.quickswitch_pixel_shipped=0

# PIHOOKS
PRODUCT_SYSTEM_PROPERTIES += \
    persist.sys.pihooks.first_api_level=32

PRODUCT_PRODUCT_PROPERTIES += \
    persist.sys.pihooks_mainline_BRAND?=google \
    persist.sys.pihooks_mainline_DEVICE?=caiman \
    persist.sys.pihooks_mainline_MANUFACTURER?=Google \
    persist.sys.pihooks_mainline_PRODUCT?=caiman

PRODUCT_BUILD_PROP_OVERRIDES += \
    PIHOOKS_MAINLINE_FINGERPRINT="google/caiman/caiman:14/AD1A.240530.047.U1/12150698:user/release-keys" \
    PIHOOKS_MAINLINE_MODEL="Pixel 9 Pro"

# PIF Fingerprint 
PRODUCT_BUILD_PROP_OVERRIDES += \
    PIHOOKS_FINGERPRINT="google/tokay_beta/tokay:15/AP41.240823.009/12329489:user/release-keys" \
    PIHOOKS_MANUFACTURER="Google" \
    PIHOOKS_MODEL="Pixel 9" \
    PIHOOKS_SECURITY_PATCH="2024-09-05" \
    PIHOOKS_DEVICE_INITIAL_SDK_INT="21"
