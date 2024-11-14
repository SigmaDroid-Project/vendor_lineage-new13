PRODUCT_BRAND ?= SigmaDroid

# GMS
ifeq ($(WITH_GMS),true)
$(call inherit-product, vendor/gms/products/board.mk)
$(call inherit-product, vendor/gms/products/gms.mk)
endif

# Privapp-permissions whitelist mode
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.control_privapp_permissions=log

# Sigma properties
PRODUCT_SYSTEM_PROPERTIES += \
    ro.sigma.build.version=$(LINEAGE_VERSION) \
    ro.sigma.display.version=$(LINEAGE_DISPLAY_VERSION) \
    ro.sigma.version=$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR) \
    ro.sigma.modversion=$(SIGMA_VERSION) \
    ro.sigma.build.package=$(SIGMA_BUILD_PACKAGE) \
    ro.sigma.maintainer=$(SIGMA_MAINTAINER) \
    ro.sigma.release.type=$(SIGMA_BUILD_TYPE) \
    ro.modversion=$(SIGMA_VERSION) \
    ro.sigma.build.date=$(shell date +%D%Y%m) \
    ro.sigma.display.build.date=$(shell date '+%Y-%m-%d') \
    ro.sigma.battery.capacity=$(SIGMA_BATTERY_CAPACITY)

# Cloned app exemption
PRODUCT_COPY_FILES += \
    vendor/lineage/prebuilt/common/etc/sysconfig/preinstalled-packages-platform-sigma-product.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/sysconfig/preinstalled-packages-platform-sigma-product.xml

# Launcher3 as Default Launcher
PRODUCT_SYSTEM_PROPERTIES += \
    persist.sys.default_launcher=0 \
    persist.sys.quickswitch_pixel_shipped=0

ifeq ($(TARGET_INCLUDE_MATLOG),true)
PRODUCT_PACKAGES += \
    MatLog
endif

# Only include Updater for official builds
ifeq ($(filter-out OFFICIAL Official official,$(SIGMA_BUILD_TYPE)),)
PRODUCT_PACKAGES += \
    SigmaUpdater

PRODUCT_COPY_FILES += \
    vendor/lineage/prebuilt/common/etc/init/init.lineage-updater.rc:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/init/init.lineage-updater.rc
endif

TARGET_SUPPORTS_QUICK_TAP ?= false
ifeq ($(TARGET_SUPPORTS_QUICK_TAP), true)
PRODUCT_PRODUCT_PROPERTIES += \
    persist.columbus.use_ap_sensor=false
endif

# RRO Packages
PRODUCT_PACKAGES += \
    AndroidOverlay \
    Launcher3Overlay

# PIHOOKS
PRODUCT_SYSTEM_PROPERTIES += \
    persist.sys.pihooks.first_api_level=32

PRODUCT_PRODUCT_PROPERTIES += \
    persist.sys.pihooks_mainline_BRAND?=google \
    persist.sys.pihooks_mainline_DEVICE?=caiman \
    persist.sys.pihooks_mainline_MANUFACTURER?=Google \
    persist.sys.pihooks_mainline_PRODUCT?=caiman

PRODUCT_BUILD_PROP_OVERRIDES += \
    PihooksBuildFp="google/caiman/caiman:14/AD1A.240530.047.U1/12150698:user/release-keys" \
    PihooksBuildModel="Pixel 9 Pro"

PRODUCT_BUILD_PROP_OVERRIDES += \
    PihooksGmsFp="google/tokay_beta/tokay:15/AP41.240823.009/12329489:user/release-keys" \
    PihooksGmsModel="Pixel 9" \
    PihooksGmsManufacturer="Google" \
    PihooksGmsSecurityPatch="2023-09-05" \
    PihooksGmsSdkVersion="21"
