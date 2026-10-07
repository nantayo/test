#!/bin/bash

# Adjust source code
mv $(dirname "$0")/992-enable-intel-guc.patch target/linux/x86/patches-6.12/
sed -i 's/^CONFIG_MICROCODE_LATE_FORCE_MINREV=y$/# CONFIG_MICROCODE_LATE_FORCE_MINREV is not set/' target/linux/x86/64/config-6.12

# Clone packages
git clone https://github.com/nantayo/My-Pkg clone/my-pkg
git clone https://github.com/QiuSimons/luci-app-daed clone/daed
git clone https://github.com/sbwml/luci-app-mosdns --single-branch --depth=1 clone/mosdns
git clone https://github.com/sbwml/v2ray-geodata --depth=1 clone/v2ray-geodata
git clone https://github.com/Zerogiven-OpenWRT-Packages/luci-app-podman --depth=1 feeds/luci/applications/luci-app-podman

# Adjust packages
rm -rf feeds/luci/applications/luci-app-daed feeds/packages/net/mosdns feeds/packages/net/v2ray-geodata feeds/packages/utils/crun
cp -rf clone/daed/luci-app-daed clone/mosdns/luci-app-mosdns feeds/luci/applications/
cp -rf clone/mosdns/geo2txt clone/mosdns/mosdns clone/v2ray-geodata feeds/packages/net/
cp -rf clone/my-pkg/feeds/. feeds/
sed -i '/luci-app-attendedsysupgrade/d' feeds/luci/collections/luci/Makefile

# Clean packages
rm -rf clone