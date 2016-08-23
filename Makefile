#
# Copyright (C) 2016 OpenWrt
# Copyright (C) 2016 Jason Lin <wojiaolinmu008@gmail.com>
#
# This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-pcap-dnsproxy
PKG_VERSION:=1.0
PKG_RELEASE:=1

PKG_LICENSE:=GPLv3
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=Jason Lin <wojiaolinmu008@gmail.com>

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/luci-app-pcap-dnsproxy
	SECTION:=luci
	CATEGORY:=LuCI
	SUBMENU:=3. Applications
	TITLE:=LuCI for pcap-dnsproxy
	PKGARCH:=all
endef

define Package/luci-app-pcap-dnsproxy/description
	LuCI for Pcap-DNSProxy. Pcap-DNSProxy, A DNS Server to avoid contaminated result.
endef

define Build/Prepare
	$(foreach po,$(wildcard ${CURDIR}/files/luci/i18n/*.po), \
		po2lmo $(po) $(PKG_BUILD_DIR)/$(patsubst %.po,%.lmo,$(notdir $(po)));)
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/luci-app-pcap-dnsproxy/conffiles
/etc/config/pcap-dnsproxy
endef

define Package/luci-app-pcap-dnsproxy/postrm
#!/bin/sh
rm -f /tmp/luci-indexcache
exit 0
endef

define Package/luci-app-pcap-dnsproxy/install
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_DATA) ./files/etc/config/pcap-dnsproxy $(1)/etc/config/pcap-dnsproxy
	
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller
	$(INSTALL_DATA) ./files/luci/controller/pcap-dnsproxy.lua $(1)/usr/lib/lua/luci/controller/pcap-dnsproxy.lua

	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/i18n
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/pcap-dnsproxy.zh-cn.lmo $(1)/usr/lib/lua/luci/i18n/	
	
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/model/cbi
	$(INSTALL_DATA) ./files/luci/model/pcap-dnsproxy.lua $(1)/usr/lib/lua/luci/model/cbi/pcap-dnsproxy.lua
	
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/etc/init.d/check $(1)/etc/init.d/check	
endef


$(eval $(call BuildPackage,luci-app-pcap-dnsproxy))
