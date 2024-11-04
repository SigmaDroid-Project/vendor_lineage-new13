PRODUCT_BRAND ?= SigmaDroid

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

ifeq ($(TARGET_INCLUDE_MATLOG),true)
PRODUCT_PACKAGES += \
    MatLog
endif