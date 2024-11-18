# Magisk WiFi Bonding

## 本修改内容用于关闭小米8SE去尝试扫描连接52及以上属于DFS的频段

不关掉会出现的故障情况是，手机连上了一个有160MHz频宽的wifi，显示连接速率是1733Mbps(160MHz频宽)，但实际上完全无法上网，因为硬件上只支持最高866Mbps(80MHz频宽)的连接
因此 如果一个开了Wifi6 160MHz频宽的路由器，小米8SE是连上了但上不了网的，因此需要关掉。

实际用法就是 clone 本项目 并且在项目目录执行下面的命令 得到 wifi_bouding.zip
然后复制到手机上用面具(magisk)安装进手机就行了。或者使用release里用github actions编译过的版本。

声明: 这个修改在我自己的6+128的小米8SE上面是一切正常的，没有测试过更多的手机，使用时请自担风险。

以下是打包脚本
```bash
wget https://github.com/topjohnwu/Magisk/raw/master/scripts/module_installer.sh -O META-INF/com/google/android/update-binary
zip -9 -x "*.git*" -r ../wifi_bonding.zip ./
sha256sum ../wifi_bonding.zip > ../wifi_bonding.zip.sha256sum
```



### 以下是原项目的原始内容

Double your bandwith on your Qualcomm devices!

高通设备 WiFi 增强模块。

## Details 细节

By default, some devices provided an ini file to control the WiFi behavior. This module modified the `WCNSS_qcom_cfg.ini` in order to support 40mhz.

默认情况下，某些设备提供了一个ini文件来控制 WiFi 行为，该模块修改了`WCNSS_qcom_cfg.ini`以支持40MHz。

- Make 2.4Ghz/5Ghz WiFi running at 40Mhz enabled. 开启 40Mhz WiFi 支持。
```
gChannelBondingMode24GHz=1
gChannelBondingMode5GHz=1
```

- Make forced WiFi antenna 1T1R on MTK solution AP disabled. 关闭联发科路由 单天线 WiFi 限制。
```
gForce1x1Exception=0
```

- Enable SAE WPA3. 开启SAE WPA3。
```
sae_enabled=1
```

- Disable BandCapability limits. 禁用频段适用限制。
```
BandCapability=0
```

This module should work on most of the devices. The basic logic is simple, but not all devices need such kind of module. If you can find `WCNSS_qcom_cfg.ini` in your system partition, please open an issue to report it to me; if you can't, this module won't work for you, including almost all Nexus/Pixel devices.

该模块可在大多数设备上使用。其逻辑很简单，但是并非所有设备都适用该模块。如果您可以在系统分区中找到`WCNSS_qcom_cfg.ini`，请创建 issue 告诉我。 如果不能，则该模块将对您的设备不起作用，包括几乎所有的 Nexus / Pixel 设备。

## Instructions 说明

Please follow the instuction below from @axeldna: 请按照说明进行操作

1. Removed the installed WiFi Bonding module. 
移除已安装了的WiFi Bonding模块。
2. Removed all saved WiFi 2.4Ghz networks (I removed all of them anyway, but shouldn't be necessary) .
移除所有已保存的2.4Ghz的WiFi（非必要）
3. Rebooted the phone (to make sure WiFi settings are removed from cloud account too). 
重启手机（以确保从云服务中删除相关的WiFi设置项）。
4. Installed the WiFi Bonding module. 安装WiFi Bonding模块。
5. Rebooted the phone (as indicated by Magisk to start the module). 
重启手机（根据Magisk指示来重启）。
6. With a phone "free of WiFi" and with a fresh WiFi Bonding module, I joined 2.4Ghz WiFi networks. 
试着开始接入2.4Ghz的WiFi。
7. Checked my newly registered 2.4Ghz networks and they are showing 150Mbps Link Speed.
自测新连上的2.4Ghz的WiFi有150Mbps的连接速度。
8. On some MTK solution AP, they are showing 300Mbps Link Speed.
连接一些联发科路由的WiFi有300Mbps的连接速度。

## NOTICE 小贴士

* You should use latest Magisk Manager to install this module. If you meet any problem under installation from Magisk Manager, please try to install it from recovery. 您应该使用最新的Magisk Manager来安装此模块。如果您在Magisk Manager中安装模块遇到问题，请尝试使用Recovery来安装

### Recent fixes: 
- Support 3rd party Magisk versions with magiskhide.  
- Support Magisk Canary(26404).  
- Fix path detection for old devices.  


## Credit & Support 版权及支持
* Any issue or pull request is welcomed. 欢迎提交 issue 以及 Pull Request
* Star this module at [GitHub](https://github.com/Magisk-Modules-Repo/wifi-bonding) 欢迎点亮项目小星星
