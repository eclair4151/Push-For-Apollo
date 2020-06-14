include $(THEOS)/makefiles/common.mk

ARCHS = arm64 arm64e
TWEAK_NAME = PushForApollo
PushForApollo_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
