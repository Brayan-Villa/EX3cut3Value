include /var/theos/makefiles/common.mk
TWEAK_NAME = EX3cutioN3R_Spoof
 EX3cutioN3R_Spoof_FILES = Tweak.mm
 EX3cutioN3R_Spoof_LIBRARIES = MobileGestalt lockdown
 EX3cutioN3R_Spoof_FRAMEWORKS = UIKit CoreFoundation
TWEAK_TARGET_PROCESS = lockdownd 
include /var/theos/makefiles/tweak.mk
TARGET_IPHONEOS_DEPLOYMENT_VERSION = 7.1.2
 EX3cutioN3R_Spoof_LDFLAGS = -lMobileGestalt -llockdown -framework IOKit  -framework CoreFoundation