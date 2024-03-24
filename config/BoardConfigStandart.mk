include vendor/standartconfig/BoardConfigKernel.mk

ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
include vendor/standart/config/BoardConfigQcom.mk
endif

include vendor/standart/config/BoardConfigSoong.mk
