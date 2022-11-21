# GL.iNet路由器官方开源固件快捷编译
## 支持设备
* GL-AX1800
* GL-AXT1800
* GL-A1300
* GL-MT2500
* GL-SF1200
* GL-SFT1200
* GL-MT1300

## 仓库说明
* 本仓库使用的源码基于GL.iNet官方开源仓库[gl-inet/gl-infra-builder](https://github.com/gl-inet/gl-infra-builder)，性能及稳定性请自行测试。
* GL-AX1800、GL-AXT1800和GL-MT2500支持官方UI。
* 本仓库可以直接通过github的action编译目标设备固件，也支持本地编译

## 定制固件
### 1.添加插件
#### a.有插件的git仓库
&emsp; 以hello word为例，在custom.yml文件中feed节点中新增子节点，name可以任意起一个，比如我就叫helloword，uri填helloword的仓库地址，revision 填写最新的commitId，然后在custom.yml 文件的packages节点下增加luci-app-ssr-plus即可。
#### b.无插件仓库
&emsp; 把自己准备的插件直接放到custom目录下，然后在custom.yml 文件的packages节点下增加相关插件名称即可。

### 2.添加自定义配置
&emsp; 可以将几乎所有自定义配置信息写入default-settings插件下的 [zzz-default-settings](custom/default-settings/files/zzz-default-settings)文件中，实现每次路由器刷写固件后像重启一样简单，无需额外在配置路由器。修改完zzz-default-settings文件后在custom.yml文件的packages节点下增加default-settings插件使自已定配置生效。

## 本地编译
```
##先自行安装编译环境
##
git clone https://github.com/JiaY-shi/build-gl.inet.git
cd build-gl.inet
./build.sh ～ ${target} false  ## ～为编译目录HOME，不建议调整； ${target}为目标设备，比如target_wlan_ap-gl-ax1800；最后一个参数是否需要官方UI，默认true 需要，不需要的话则填false
```

## 设备和目标的对应关系
|  目标   | 设备  |
|  ----  | ----  |
|target_wlan_ap-gl-ax1800|GL-AX1800 4.4内核|
|target_wlan_ap-gl-axt1800|GL-AXT1800 4.4内核|
|target_wlan_ap-gl-ax1800-5-4|GL-AX1800 5.4内核|
|target_wlan_ap-gl-axt1800-5-4|GL-AXT1800 5.4内核|
|target_ipq40xx_gl-a1300|GL-A1300|
|target_mt7981_gl-mt2500|GL-MT2500|
|target_siflower_gl-sf1200|GL-SF1200|
|target_siflower_gl-sft1200|GL-SFT1200|
|target_ramips_gl-mt1300|GL-MT1300|
