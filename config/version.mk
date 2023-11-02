# Build fingerprint
ifneq ($(BUILD_FINGERPRINT),)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.build.fingerprint=$(BUILD_FINGERPRINT)
endif

# Internal version
STANDARTOS_VERSION := QPR1
STANDARTOS_BUILD_TYPE ?= unsigned

# Platform version
PLAT_VERSION := 14.0

TARGET_PRODUCT_SHORT := $(subst aosp_,,$(STANDART_BUILD))
STANDARTOS_VERSION := StandartOS_$(TARGET_PRODUCT_SHORT)-$(PLAT_VERSION)_$(STANDARTOS_VERSION)-$(shell date +%Y%m%d-%H%M)

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.build.version.custom=$(STANDARTOS_VERSION) \
    ro.build.version.device=$(TARGET_PRODUCT_SHORT) \
    ro.standart.build.version=$(STANDARTOS_VERSION) \
    ro.standart.buildtype=$(STANDARTOS_BUILD_TYPE)
