# Charger
#ifneq ($(WITH_SLIM_CHARGER),false)
#    BOARD_HAL_STATIC_LIBRARIES := libhealthd.slim
#endif

include vendor/skydragon/config/BoardConfigKernel.mk

ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
include vendor/skydragon/config/BoardConfigQcom.mk
endif

include vendor/skydragon/config/BoardConfigSoong.mk

