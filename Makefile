# Copyright (C) 2018-2019 Lienol
#
# This is free software, licensed under the Apache License, Version 2.0 .
#

include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-adguardhome
PKG_VERSION:=1.0
PKG_RELEASE:=1

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/luci-app-adguardhome
	SECTION:=luci
	CATEGORY:=LuCI
	SUBMENU:=3. Applications
	TITLE:=LuCI Support for adguardhome
	DEPENDS:=
endef

define Package/luci-app-adguardhome/description
	LuCI support for adguardhome
endef

define Build/Prepare
endef

define Build/Compile
endef

define Package/luci-app-adguardhome/install
    $(INSTALL_DIR) $(1)/usr/lib/lua/luci
	cp -pR ./luasrc/* $(1)/usr/lib/lua/luci
	$(INSTALL_DIR) $(1)/
	cp -pR ./root/* $(1)/
endef

define Package/luci-app-adguardhome/postinst
#!/bin/sh
	/etc/init.d/AdGuardHome enable >/dev/null 2>&1
exit 0
endef

define Package/luci-app-adguardhome/prerm
#!/bin/sh
if [ -z "$${IPKG_INSTROOT}" ]; then
     /etc/init.d/AdGuardHome disable
     /etc/init.d/AdGuardHome stop
fi
exit 0
endef

$(eval $(call BuildPackage,luci-app-adguardhome))