# 斐讯N1(Phicomm-N1)刷机

下图是传说中的斐讯N1S（从恩山扣的图）  
![image](https://user-images.githubusercontent.com/30925759/205446154-42a7c0f6-81b4-4f46-9662-2775cf5455a2.png "斐讯N1S")    
<br/>

> 
> 一. 斐讯原版系统降级操作  
> 二. 刷机  
> 三. 安装v2ray客户端  
<br/>

## 一. 斐讯原版系统降级操作  
参考***网心云***的教程【三方盒子(FX)刷机包】：https://www.onethingcloud.com/download-center/    
如果刷机失败，参考教程【FX刷机失败，救砖工具】里面的救砖操作。   
在[安装教程](https://help.onethingcloud.com/7cb4/3ed5/77f6)中的步骤“第六步：刷机”时，要换成刷armbian镜像。  

点击下载[刷机工具包](https://update.peiluyou.com/downloads/S905D-N1-Burning-Guide-V3.0.zip)，将工具包下载后解压；    
![image](https://user-images.githubusercontent.com/30925759/204098246-2432b608-098f-40e2-b503-245e6c20620e.png)  
需要注意的是，`s905_usb_burn_img_V3.1.7.zip`是网心云系统镜像包，`S905D-N1-Burning-Guide-V3.0.zip`是N1刷机工具包。  
使用刷机工具包`S905D-N1-Burning-Guide-V3.0.zip`的整个过程操作：依次执行脚本，`第2步进入fasteboot.bat`-->`第3步检查是否可以降级.bat`-->`第4步降级.bat`-->`第5步降级完成后执行重启.bat`-->刻录U盘-->`第6步进入U盘模式开始刷机.bat`。  

N1开机后，进入N1主画面（安卓系统），将N1和电脑接入同一局域网，用USB双公头线连接电脑和N1的靠近HDMI接口的USB口（先接电源再接usb双公头线）；   
![image](https://user-images.githubusercontent.com/30925759/204096778-8b87e14c-df41-4c76-abc3-dc0871625955.png)  
记下N1的内网IP地址；  
打开adb(Android Debug Bridge) ，开启远程调试，在***固件版本***的位置，连续点击4下鼠标左键，主页会弹出一个提示“打开adb”；  
![image](https://user-images.githubusercontent.com/30925759/204096810-54def087-75c1-46b3-b1a8-4311d4ff638f.png)  

通过adb网络连接N1（用tcp无线调试模式，不是usb调试模式），使设备重启后进入fastboot模式；  
```
#用TCP连接设备（默认端口是5555）
adb connect N1内网IP
#显示adb连接的设备列表
adb devices -l
#重启至fastboot模式
adb shell reboot fastboot
```

N1进入fastboot线刷模式后（通过双公头线USB通信），会听到电脑有个“叮咚”的有新硬件接入提示音，可以在“我的电脑-管理-计算机管理-设备管理器”页面查看是否识别出了已连接设备；  
![image](https://user-images.githubusercontent.com/30925759/204121568-383c7823-c0f1-4236-ba39-d3ddb4967a05.png)  
如果新设备处显示黄色感叹号（此时执行`fastboot devices`读取不到设备），驱动异常，则需要安装“Android ADB Interface”驱动。可以在“windows更新-查看可选更新-驱动程序更新”处下载驱动更新，也可以去微软网站下载安装[LeMobile驱动程序](https://www.catalog.update.microsoft.com/Search.aspx?q=lemobile)。  
![image](https://user-images.githubusercontent.com/30925759/204122362-182b8aa2-153a-46be-93b6-08d72f9c0110.png)  
或者去谷歌网站下载[Google USB 驱动程序ZIP文件](https://developer.android.google.cn/studio/run/win-usb?hl=zh-cn)，在“设备管理器”页面，右键点击已连接设备的名称，然后选择“更新驱动程序”，手动更新安装驱动。  

在fastboot线刷模式下，检查是否可降级，执行降级操作；  
如果固件版本是V2.22~V2.32，则需要换掉斐讯的bootloader，将boot分区降级到低版本。如果固件版本是V2.19，那么不需要降级。  
降级完成后，N1主界面上显示的***固件版本***不会有变化。  
```
#查看Fastboot模式下连接的的设备，会返回类似XXXXXXXXXXXX fastboot这样的提示（XXXXX为序列号），表示fastboot工具已识别设备
fastboot devices –l
#
fastboot flash bootloader bootloader.img  
fastboot flash boot boot.img  
fastboot flash recovery  recovery.img
#重启
fastboot reboot
```

## 二. 刷机  

``` markdown
    1. 刷入armbian系统
    2. 刷入openwrt系统
```

1. 安装armbian  
新装和重装系统都一样。装linux不需要用USB_Burning_Tool烧录。  
    (1)刻录U盘镜像  
    **用个好一点的U盘，像Kingston、SanDisk，读写速度在10MB/s以上，最好接口是usb2.0的，用杂牌U盘可能会出现无法从U盘启动或者进入Android Recovery界面的情况**  
    使用`balbes150`大神的armbian镜像  
    系统镜像下载：https://users.armbian.com/balbes150/arm-64/  
    ![image](https://user-images.githubusercontent.com/30925759/168515862-2e065d13-7c6a-4d34-8a30-829c287f6e5b.png)  
    
    比如选择`Armbian_20.10_Arm-64_bullseye_current_5.9.0.img.xz`下载（N1的GPU性能不错，能跑4k解码，可以装Desktop版）  
    解压后，用`USB Image Tool`或者`Win32DiskImager`或者`balenaEtcher`或者`Rufus`刻录  
    ![image](https://user-images.githubusercontent.com/30925759/204129696-1e12cbca-8273-4ba4-87c2-417a306ff5f6.png)  
    刻录完成后，在“我的电脑-管理-计算机管理-磁盘管理”页面，看到有2个磁盘分区，其中一个是以“BOOT”为卷标的  
    ![image](https://user-images.githubusercontent.com/30925759/204141539-beed3851-1e9f-4046-abae-22a2c118d6e2.png)  
    
    这个固件更新
    https://github.com/ophub/amlogic-s9xxx-armbian/blob/main/README.cn.md  
    
    (2)配置n1的armbian安装参数  
    **注意，以下步骤适用于Armbian 20.08及之后的版本**    
    安装参考帖子：https://forum.armbian.com/topic/12162-single-armbian-image-for-rk-aml-aw-aarch64-armv8/  
    打开刻录好的U盘根目录，如下图所示：  
    ![image](https://user-images.githubusercontent.com/30925759/204125536-a7f8bbd2-11a7-4471-a76e-6721d4eec050.png)  
    
    a.修改`extlinux`目录下的`extlinux.conf`文件：  
    前三行不变，之后的行全用`#`注释；修改“# aml s9xxx”处，新增加一条`FDT /dtb/amlogic/meson-gxl-s905d-phicomm-n1.dtb`，解除`APPEND`那行的注释  
    ![image](https://user-images.githubusercontent.com/30925759/204125773-88adca97-f9c9-44f4-ace0-2188b7ebf514.png)  
    
    b.把U盘根目录下的`u-boot-s905x-s912`重命名为`u-boot.ext`  
    
    (3)安装armbian系统，把armbian系统写入EMMC  
    a.将刻录好的U盘插入到斐讯的N1盒子靠近hdmi的USB口（**不要插入键盘鼠标**）   
    ![image](https://user-images.githubusercontent.com/30925759/204118410-299ad3b4-ded3-42b0-b77d-7c39b9cfc445.png)  
    使用adb命令重启设备  
    ```
    adb connect N1内网IP
    adb shell reboot update
    ```
    重启后，N1会从U盘启动并进入armbian系统（N1现在已经是优先从U盘启动）----**这种方式会出现文件权限被修改污染的情况**  
    
    也可以，先断电源，将U盘插入靠近HDMI的USB口，插入网线、HDMI，**不要插入键盘鼠标**，再插入电源后设备启动。断电重启N1后，N1同样会从U盘启动并进入armbian系统   
    
    b.<a id="install-armbian-b">在设备重新启动后</a>，显示器出现斐讯开机画面，之后会黑屏一会儿（此时正从U盘加载数据，黑屏时间与U盘读写速度有关），等待亮屏后会自动加载armbian系统  
    ![image](https://user-images.githubusercontent.com/30925759/204523053-61a8968d-4672-439f-be23-b9707635694a.png)  
    亮屏后，开机引导会自动初始化加载armbian，**此时可以插入键盘鼠标了（一定要快，不要等进入armbian控制台界面后再插入，否则控制台可能会出现加载error情况）**  
    ![image](https://user-images.githubusercontent.com/30925759/204522793-08543010-d2de-4946-ac73-73c36bfbf3b8.png)  
    开机引导执行完了后，进入armbian，设置root的新密码，语言区域，创建新用户等  
    ![image](https://user-images.githubusercontent.com/30925759/204522617-99c763a1-5618-475e-80da-334772da7c8e.png)  
    
    > 如果在开机画面卡死，可以断电重启N1，拔掉键盘鼠标，只插HDMI和u盘，断电5秒后在插入电源。  
    > 如果进入了android recovery界面，大概率是U盘不行，需要换个好一点的U盘试试。  
    > 如果没有从U盘启动，还是启动进入了斐讯系统，则使用adb命令重启设备再一次尝试从U盘启动。  
    > 如果由开机画面进入黑屏，持续长时间几分钟，可以断电重启N1，拔掉键盘鼠标，只插HDMI和u盘，断电5秒后在插入电源。  
    > 如果闪屏（开机画面->黑屏->开机画面->黑屏...），需要拔掉键盘鼠标。  
    > 如果出现开不了机（显示器黑屏无响应），或者在开机引导初始化加载时出现“random: crng init done”进入了`initramfs`模式，插上用U盘，断电10秒后重启，多试几次，或者重新刻录U盘再试，或者先刷低版本成功后再刷高版本，无需线刷回Android系统。  
    
    c.检查文件权限owner是否是root，如果被修改了，只能重新刻录U盘，再重新安装    
    解决方案参考：https://github.com/ophub/amlogic-s9xxx-armbian/issues/501  
    下图所示，这里文件所有者被改成了1023，应该是在Android系统运行时，插入了U盘，导致文件和目录权限被Android系统修改了  
    ![image](https://user-images.githubusercontent.com/30925759/204846918-47ce9578-459f-4248-b495-5aef41924100.png)  
    
    d.将armbian系统从U盘写入N1的emmc，执行命令`./install-aml.sh`  
    ![image](https://user-images.githubusercontent.com/30925759/204847570-3aaa05ce-d181-46cd-956f-4227e170ad25.png)  
    
    e.执行`poweroff`关机，拔出u盘，**拔掉键盘鼠标**，再插入电源重新开机  
    **注意，只能在N1开机后插入键盘鼠标，否则会出现闪屏或者黑屏无法启动的情况**       
    查看系统版本信息`cat /etc/lsb-release`、`cat /etc/issue`  
    
    > 关于***重装系统***  
    > 写入emmc后，系统将优先从EMMC启动。如果想改为优先从U盘启动，需要修改`/boot/extlinux/extlinux.conf`文件，把`ROOT_EMMC`改为`ROOTFS`，再插上U盘，**不要插入键盘鼠标**，重启系统，<a href="#install-armbian-b">N1会从U盘启动并进入armbian系统</a>       
    > ![image](https://user-images.githubusercontent.com/30925759/204547998-a5c0fc47-76fe-498e-b310-21603d701d08.png)    
    
    f.修改设备树dtb文件，降低cpu负载（也可以在安装armbian前，用现成的dtb文件替换掉U盘中/dtb/amlogic下的meson-gxl-s905d-phicomm-n1.dtb文件，替换文件前要先备份）  
    ```
    #新建文件夹newdtb
    mkdir /root/newdtb
    #备份固件自带的dtb文件
    cp -a /boot/dtb/amlogic/meson-gxl-s905d-phicomm-n1.dtb /boot/dtb/amlogic/meson-gxl-s905d-phicomm-n1.dtb.bak
    #反编译固件自带的dtb文件
    dtc -I dtb -O dts -o /root/newdtb/meson-gxl-s905d-phicomm-n1.dts /boot/dtb/amlogic/meson-gxl-s905d-phicomm-n1.dtb
    #对反编译出的dts文件进行编辑。搜索9880，注释phandle =< 0x21 >行（也就是第262行）
    vim /root/newdtb/meson-gxl-s905d-phicomm-n1.dts
    #编译出新dtb文件
    dtc -I dts -O dtb -o /root/newdtb/meson-gxl-s905d-phicomm-n1.dtb /root/newdtb/meson-gxl-s905d-phicomm-n1.dts
    #覆盖固件自带的dtb文件
    cp /root/newdtb/meson-gxl-s905d-phicomm-n1.dtb /boot/dtb/amlogic/meson-gxl-s905d-phicomm-n1.dtb
    #重启
    reboot
    ```
    
    至此，armbian已经安装成功。  
    
    (4)安装后的优化配置  
    - A.使用`armbian-config`图形化界面更新系统  
        菜单路径【System-Firmware】，可能会失败，一般重复多试几次就可以了。  
        不要直接执行`apt update && apt upgrade`更新系统，特别是在选“Y”时要特别注意，否则会更改适配N1的系统配置。  
        可以先换源的地址`vim /etc/apt/sources.list`，再进行更新，注意的是地址路径中的版本号名称一定要与本系统的版本号名称一致。  
        有的系统armbian-config版本可以直接用`armbian-config`图形化界面换镜像源，路径是“armbian-config -> Personal -> Mirrors -> 选一个源 -> Ok”。如果没有Mirrors菜单，执行`apt install --only-upgrade armbian-config`更新升级armbian-config软件版本。执行`apt list --installed armbian-config`查看当前已安装版本。    
        同时，也可以指定下docker官方源，例如Ubuntu的，参考官方文档`https://docs.docker.com/engine/install/ubuntu/`，复制粘贴命令跑下就可以了  
        ![image](https://user-images.githubusercontent.com/30925759/173090104-9781c858-0273-47ad-bae2-2a380d8061b8.png)  
        
    - B.使用`armbian-config`图形化界面配置ssh  
        菜单路径【System-SSH】  
        ![image](https://user-images.githubusercontent.com/30925759/168535411-c45c3626-2d2b-4c85-ae8d-15d2816bc7b8.png)  

    - C.使用`armbian-config`图形化界面配置时区  
        菜单路径【Personal-Timezone】，选择shanghai  
        
    - D.使用`armbian-config`图形化界面配置语言和区域  
        > 设置中文环境时要安装中文字体，否则中文会乱码。中文语言包`apt-get install language-pack-zh-han*`，文泉驿正黑`apt-get install fonts-wqy-zenhei`，文泉驿微米黑`apt-get install fonts-wqy-microhei`，google思源字体`apt-get install fonts-noto-cjk`；  
        > 安装字体时，会同时安装依赖软件包`fontconfig`；更新字体缓存`fc-cache -v`；
        > 安装中文字体后，需要注销当前会话重新登录`exit`，或者重启系统`reboot`。  
        
        菜单路径【Personal-Locales】，按“上下键”、“空格键”和“Tab键”来切换、选中或取消选中对应的选项，选中“en_US.UTF-8”、“zh_CN.GBK”、“zh_CN.UTF-8”，Ok回车进入下一步  
        *locale的命名规则为<语言>_<地区>.<字符集编码>，如zh_CN.UTF-8，zh代表中文，CN代表大陆地区，UTF-8表示字符集。*  
        ![image](https://user-images.githubusercontent.com/30925759/168517724-9c527cd3-853f-4cd5-bae3-a073e2252bf2.png)  
        默认“语言_地区.字符集”选择“en_US.UTF-8”  
        ![image](https://user-images.githubusercontent.com/30925759/168517771-eaaef55e-7db8-4e13-99d3-56eace8f4d63.png)  
        
        >不使用armbian-config来配置系统区域设置时：  
        >开启系统支持的字库`vi /etc/locale.gen`，字符集用“UTF-8”的，去掉“zh_CN.UTF-8”那行的注释`#`。也可以使用locale-gen命令来安装某种locale，比如安装zh_CN.UTF-8字库，执行命令`locale-gen zh_CN.UTF-8`。  
        >使用命令`locale -a`查看系统目前支持的所有语言包。    
        >设置默认语言`vi /etc/default/locale`。全中文环境改成`LANGUAGE=zh_CN.UTF-8`、`LANG=zh_CN.UTF-8`，增加`LC_ALL=zh_CN.UTF-8`。半中文环境改成`LANGUAGE=zh_CN.UTF-8`、`LANG=en_US.UTF-8`，增加`LC_CTYPE=zh_CN.UTF-8`。也可以使用命令`update-locale LANG=zh_CN.UTF-8`来修改。  
        >使用命令`locale`查看当前locale设置。  
        >![image](https://user-images.githubusercontent.com/30925759/168545445-87a4bfc1-77f5-41a4-a6c8-8adf78867c94.png)  
        >修改环境变量`vi /etc/environment`，添加`LC_ALL=zh_CN.UTF-8`。  
        >重启系统`reboot`。  
        
        >1. 全新字符库编码信息位于 /usr/share/i18n目录下面，其中SUPPORTED中包含可用的所用字符集。其中的charmaps存的每种字符集的映射信息。使用localedef可以生成字符集，就是locales里面那些东西。但这些并不是系统中能用的字符集。刚才描述的这些/usr/share/i18n里面的文件只能算是可用的字符集，locale -m可以看到列表。
        >![image](https://user-images.githubusercontent.com/30925759/204591658-6e1defa1-ef30-42b2-9192-13e0ed355911.png)  
        >2. 为了让系统能使用，原始的/usr/share/i18n中的文件要经过处理（complile），能用的字符编码在/usr/lib/locale/下面，成为complied字符集。
        >3. 使用locale-gen可以把原始的/usr/share/i18n中的文件complie成系统能用的/usr/lib/locale/地字符集。所以当使用locale-gen 命令出现由某些文件确实而失败的情况，往往是由/usr/share/i18n下缺少相应文件导致的。
        >4. /usr/share/i18n里面的东西操作系统无关，不同体系结构不同系统可以通用，若有缺失，从其他地方复制来便可。
        
    - E.使用`armbian-config`图形化界面配置wifi  
        菜单路径【Network-WiFi】  
        ![image](https://user-images.githubusercontent.com/30925759/204567305-0a839e21-3a52-420c-a412-3d982c2a1a32.png)  
        如果没有WiFi菜单，重启network-manager，或者执行`apt install network-manager`重装network-manager  
        
    - F.使用`armbian-config`图形化界面安装docker  
        菜单路径【Software-Softy】，选中docker，Install回车进行安装  
        ![image](https://user-images.githubusercontent.com/30925759/168517516-e3240021-5d4f-4c96-8916-37412d783479.png)  
        安装完成后，用命令`docker version`查看docker版本  
        ![image](https://user-images.githubusercontent.com/30925759/168537798-5b88485f-698d-4b37-8b32-516199a3411d.png)  
        
    - G.关闭日志服务写入emmc，延长emmc寿命  
        系统使用了zram磁盘      
        ![image](https://user-images.githubusercontent.com/30925759/168519447-21219e8a-7c76-4573-9fbf-ecb5eb971e70.png)  
        编辑`armbian-ramlog`文件，`vim /etc/default/armbian-ramlog`，true是开启，false是关闭  
        ![image](https://user-images.githubusercontent.com/30925759/168515966-6c212e0d-97fb-4d00-9ec9-00ebfce4c6d8.png)  
        
        或者，关闭syslog系统日志服务  
        ```shell
        systemctl disable syslog
        systemctl stop syslog
        ```
        
    - H.关闭防火墙  
        默认状态已经是关闭了的。在自己用的内网环境中不需要开启防火墙  
        
    - I.使用“usbmount”实现USB设备自动挂载  
        dpkg -i usbmount_0.0.24_all.deb  
        /etc/usbmount/usbmount.conf
    - J.把移动硬盘当作系统盘或数据盘用，固定到指定的挂载点，实现开机自动挂载移动硬盘    
        fdisk -l  
        blkid  
        vim /etc/fstab  
        UUID=50C7117B50C50979 /mnt/hdd1T  ntfs  defaults,nofail,x-systemd.device-timeout=1,noatime 0 0  
        UUID=50C7117B50C50979  /mnt/sda1 ntfs defaults 0 1  
    
2. 安装openwrt  
n1就一个网口，直接用newifi刷机了。:joy:<br>
    openwrt下载：https://openwrt.org/
    
    <br>斐讯路由器<br>
    ![image](https://user-images.githubusercontent.com/30925759/168520652-bf563d55-692a-41c8-9bfb-815609015cf8.png)
    <br>优酷路由器<br>
    ![image](https://user-images.githubusercontent.com/30925759/168520662-e9b9a169-b2f1-4c9a-a9a3-a5311cf84f1c.png)
    <br>谛听newifi路由器<br>
    ![image](https://user-images.githubusercontent.com/30925759/168520678-8706de67-81aa-47ce-b2eb-ef6a4e23d597.png)
    
## 三. 安装v2ray客户端  
参考：https://guide.v2fly.org/  

> 1. [使用docker安装](#v2ray-docker)  
> 2. <a href="#v2ray-deb">使用deb包安装</a>    

1. <span id="v2ray-docker">使用docker安装</span><br>
    拉[DockerHub](https://hub.docker.com/r/v2fly/v2fly-core)中的镜像`docker pull v2fly/v2fly-core`  
    查看镜像`docker images`  
    ![image](https://user-images.githubusercontent.com/30925759/168521492-e1d3253f-6585-4b71-9113-128dc79b5cae.png)
    创建文件夹`mkdir -p /data/v2ray/conf`，上传`config.json`文件  
    创建并启动容器`docker run -d --name v2ray-4.45.0 --network host -v /data/v2ray/conf:/etc/v2ray -v /data/v2ray/logs:/var/log/v2ray v2fly/v2fly-core`    
    另外，geoip.dat和geosite.dat放在容器的目录`/usr/local/share/v2ray/`下，创建文件夹`mkdir -p /data/v2ray/share`，上传文件后，在`docker run`命令中增加挂载目录映射`-v /data/v2ray/share:/usr/local/share/v2ray`，重新创建容器    
    查看容器`docker ps`  
    ![image](https://user-images.githubusercontent.com/30925759/168528211-51dced4a-7465-4790-8f6c-6798f8dad689.png)

2. <a name="v2ray-deb">使用deb包安装</a>  
    下载：https://pkgs.org/download/v2ray
    <br>
    下载：https://github.com/dreamrover/v2ray-deb
    <br>
