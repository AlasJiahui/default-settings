# Copyright (C) 2016-2023 GitHub
# Updated for OpenWrt 25.12
#
# This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.

include $(TOPDIR)/rules.mk

PKG_NAME:=default-settings
PKG_RELEASE:=$(COMMITCOUNT)
PKG_LICENSE:=GPLv3
PKG_LICENSE_FILES:=LICENSE

# 更新依赖
PKG_BUILD_DEPENDS:=luci-base/host

include $(INCLUDE_DIR)/package.mk

define Package/default-settings
  SECTION:=luci
  CATEGORY:=LuCI
  TITLE:=LuCI support for Default Settings
  PKGARCH:=all
  DEPENDS:= +luci-base +@LUCI_LANG_zh-cn +@LUCI_LANG_zh_Hans +@LUCI_LANG_en
endef

define Package/default-settings/description
	Language Support Packages and default settings.
endef

define Build/Compile
	# 确保 po2lmo 工具可用
	$(call Build/Compile/Default)
	$(STAGING_DIR_HOST)/bin/po2lmo ./po/zh-cn/default.po $(PKG_BUILD_DIR)/default.zh-cn.lmo
endef

define Package/default-settings/install
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_BIN) ./files/zzz-default-settings $(1)/etc/uci-defaults/99-default-settings

	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/i18n
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/default.zh-cn.lmo $(1)/usr/lib/lua/luci/i18n/default.zh-cn.lmo

	# 添加版本标记文件（可选）
	$(INSTALL_DIR) $(1)/etc/openwrt_release
	echo "default-settings-$(PKG_VERSION)-$(PKG_RELEASE)" > $(1)/etc/openwrt_release/default_settings_version
endef

$(eval $(call BuildPackage,default-settings))
