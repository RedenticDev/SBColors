INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = SBColors

SBColors_FILES = Tweak.x
SBColors_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
