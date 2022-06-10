
一. 斐讯原版系统降级操作  
参考***网心云***的教程【三方盒子(FX)刷机包】：https://www.onethingcloud.com/download-center/  
在[安装教程](https://help.onethingcloud.com/7cb4/3ed5/77f6)中的步骤“第六步：刷机”就不要执行了，要换成刷armbian。如果刷机失败，参考教程里面的救砖操作。   

二. 刷机  

``` markdown
    1. 刷入armbian系统
    2. 刷入openwrt系统
```

1. 安装armbian  
新装和重装系统都一样。  
    (1)刻录U盘镜像  
    使用`balbes150`大神的armbian镜像  
    系统镜像下载：https://users.armbian.com/balbes150/arm-64/  
    ![image](https://user-images.githubusercontent.com/30925759/168515862-2e065d13-7c6a-4d34-8a30-829c287f6e5b.png)
    
    (2)配置n1的armbian安装参数  
    安装参考帖子：https://forum.armbian.com/topic/12162-single-armbian-image-for-rk-aml-aw-aarch64-armv8/  
    
    (3)把armbian系统写入EMMC  
    
    (4)安装后的优化配置  
    - A.使用`armbian-config`图形化界面配置wifi  
        菜单路径【Network-WiFi】  
        
    - B.使用`armbian-config`图形化界面配置ssh  
        菜单路径【System-SSH】  
        ![image](https://user-images.githubusercontent.com/30925759/168535411-c45c3626-2d2b-4c85-ae8d-15d2816bc7b8.png)

    - C.使用`armbian-config`图形化界面配置时区  
        菜单路径【Persion-Timezone】  
        
    - D.使用`armbian-config`图形化界面配置语言  
        安装中文字体，文泉驿正黑`apt-get install fonts-wqy-zenhei`，文泉驿微米黑`apt-get install fonts-wqy-microhei`，google思源字体`apt-get install fonts-noto-cjk`  
        更新字体缓存`fc-cache -v`  
        
        > 开启字库`/etc/locale.gen`，也可以使用`armbian-config`进行配置  
        > 设置默认语言`/etc/default/locale`，也可以使用`armbian-config`进行配置。如果要设置成中文环境，改成`LANGUAGE=zh_CN.UTF-8`、`LANG=zh_CN.UTF-8`，全中文环境增加`LC_ALL=zh_CN.UTF-8`，半中文环境增加`LC_CTYPE=zh_CN.UTF-8`和`LANG=en_US.UTF-8`    
        
        菜单路径【Persion-Locales】，按“上下键”、“空格键”和“Tab键”来切换、选中或取消选中对应的选项，选中“en_US.UTF-8”、“zh_CN.GBK”、“zh_CN.UTF-8”，Ok回车进入下一步  
        ![image](https://user-images.githubusercontent.com/30925759/168517724-9c527cd3-853f-4cd5-bae3-a073e2252bf2.png)
        默认语言选择“en_US.UTF-8”  
        ![image](https://user-images.githubusercontent.com/30925759/168517771-eaaef55e-7db8-4e13-99d3-56eace8f4d63.png)
        ![image](https://user-images.githubusercontent.com/30925759/168545445-87a4bfc1-77f5-41a4-a6c8-8adf78867c94.png)
        安装中文字体后，需要重启系统`reboot`
        
    - E.使用`armbian-config`图形化界面更新系统  
        菜单路径【System-Firmware】，可能会失败，一般重复多试几次就可以了。  
        也可以先换源的地址`vim /etc/apt/sources.list`，再进行更新，注意的是地址路径中的版本号名称一定要与本系统的版本号名称一致，有的系统版本可以直接用`armbian-config`换镜像源，“armbian-config -> Person -> Mirrors -> 选一个源 -> Ok”。    
        也可以指定下docker官方源，例如Ubuntu的，参考官方文档`https://docs.docker.com/engine/install/ubuntu/`，复制粘贴命令跑下就可以了  
        ![image](https://user-images.githubusercontent.com/30925759/173090104-9781c858-0273-47ad-bae2-2a380d8061b8.png)
        
    - F.使用`armbian-config`图形化界面安装docker  
        菜单路径【Software-Softy】，选中docker，Install回车进行安装  
        ![image](https://user-images.githubusercontent.com/30925759/168517516-e3240021-5d4f-4c96-8916-37412d783479.png)
        安装完成后，查看docker版本`docker version`  
        ![image](https://user-images.githubusercontent.com/30925759/168537798-5b88485f-698d-4b37-8b32-516199a3411d.png)
        
    - G.关闭日志服务写入emmc，延长emmc寿命  
        ![image](https://user-images.githubusercontent.com/30925759/168519447-21219e8a-7c76-4573-9fbf-ecb5eb971e70.png)
        编辑`armbian-ramlog`文件，`vim /etc/default/armbian-ramlog`，true是开启，false是关闭  
        ![image](https://user-images.githubusercontent.com/30925759/168515966-6c212e0d-97fb-4d00-9ec9-00ebfce4c6d8.png)
    - H.关闭防火墙  
        默认状态已经是关闭了的。在自己用的内网环境中不需要开启防火墙
        
2. 安装openwrt  
n1就一个网口，直接用newifi刷机了。:joy:<br>
    openwrt下载：https://openwrt.org/
    
    <br>斐讯路由器<br>
    ![image](https://user-images.githubusercontent.com/30925759/168520652-bf563d55-692a-41c8-9bfb-815609015cf8.png)
    <br>优酷路由器<br>
    ![image](https://user-images.githubusercontent.com/30925759/168520662-e9b9a169-b2f1-4c9a-a9a3-a5311cf84f1c.png)
    <br>谛听newifi路由器<br>
    ![image](https://user-images.githubusercontent.com/30925759/168520678-8706de67-81aa-47ce-b2eb-ef6a4e23d597.png)
    
三. 安装v2ray客户端  
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
