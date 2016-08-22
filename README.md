OpenWrt/LEDE LuCI for Pcap-DNSProxy
===

特性
---

软件包不包含 [Pcap-DNSProxy](https://github.com/wongsyrone/openwrt-Pcap_DNSProxy) 的可执行文件,需要用户自行添.
可执行文件,可通过安装提供的 [Pcap-DNSProxy] 获得.  

软件包文件结构:
```
/
├── etc/
│   ├── config/
│   │   └── pcap-dnsproxy                            // UCI 配置文件
│   └── init.d/
│       └── check                                    // init 守护脚本
└── usr/
    └── lib/
        └── lua/
            └── luci/                                // LuCI 部分
                ├── controller/
                │   └── pcap-dnsproxy.lua            // LuCI 菜单配置
                ├── i18n/                            // LuCI 语言文件
                │   └── pcap-dnsproxy.zh-cn.lmo
                └── model/
                    └── cbi/
                        └── pcap-dnsproxy.lua        // LuCI 基本设置界面
```

依赖
---

 1. `Pcap_DNSProxy` 必需  
    init 脚本执行时会先检查 `ss-redir` 是否存在,
    如果存在就可以启动相应的进程,
    否则包括 LuCI 在内的所有功能都将无法使用.

注: 一定要安装`Pcap_DNSProxy先`，再安装`luci-app-pcap-dnsproxy`
```

编译
---

从 OpenWrt 的 [SDK](http://wiki.openwrt.org/doc/howto/obtain.firmware.sdk) 编译  
```bash
# 解压下载好的 SDK
tar xjf OpenWrt-SDK-ar71xx-for-linux-x86_64-gcc-4.8-linaro_uClibc-0.9.33.2.tar.bz2
cd OpenWrt-SDK-ar71xx-*
# Clone 项目
git clone https://github.com/houzi-/luci-app-pcap-dnsproxy.git package/luci-app-pcap-dnsproxy
# 编译 po2lmo (如果有po2lmo可跳过)
pushd package/luci-app-pcap-dnsproxy/tools/po2lmo
make && sudo make install
popd
# 选择要编译的包 LuCI -> 3. Applications
make menuconfig
# 开始编译
make package/luci-app-pcap-dnsproxy/compile V=99
```
