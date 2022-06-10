# 矿池中转代理解决方案mining-pool-proxy-solution
**2022-02-01**  
 
 > 春节放假了，来总结一下“现在怎么样连接矿池”，避免被抽水。  
 > 自从去年12月份开始，在政策要求下，各大运营商GFW先是对各大矿池的dns污染，接着又封矿池的ip和端口，于是，在云服务商那里买的vps（1核1G内存40G硬盘1M宽带）这次派上大用场了，之前一直拿它来上个github，顺便看个YouTube等等，小水管勉强够用。有一段时间，这台vps开放的80端口一直被ddos和cc，搞得cpu和带宽被吃满，只好加了防火墙。我刚开始时是在vps上用nginx做了[ethermine](https://www.ethermine.org/)端口转发代理，后续在贴吧上看到了好多顺着ip上门社区送温暖的暖心场景，把我直接感动的不得了，赶紧换了代理方案。  
 > 再后来，由于后面持续进行自我批评自我反省，为了响应政策要求，已经**停机卖卡**了。  
 
 &nbsp;   
 想了一下，归纳为`4`种方案：  
 ```markdown
 1. 使用现成的vpn服务（推荐）
 2. 端口代理
 3. 自建vpn科学上网（推荐）
 4. 手写一个端口加密中转服务
 ```
 
 ### 1. 使用现成的vpn服务  
 购买vpn服务，在电脑上装上服务商提供的vpn客户端，选择它的全局代理模式。如果vpn有客户端数量限制，那就在本地局域网内，找台已经安装好vpn客户端的机子，用来做端口转发代理，其他局域网机子挖矿内核程序调用指向本地这台代理机子。  
 
 ![image](https://user-images.githubusercontent.com/30925759/152677373-3fe36a22-3b53-4433-a4c0-81f76c97efb0.png)  
 
 我之前用过`蓝灯`、~~`云帆VPN`~~（已跑路）、`快连VPN`等等，（在这儿不是做广告）用起来感觉还可以，像快连，便宜的会员一年200多块钱，流量随便用。  
 <img src=https://user-images.githubusercontent.com/30925759/159161455-592cdf34-585b-4061-b981-58d8316f9938.jpg width=40% />

 用这种vpn服务是不用操心网络连通，由vpn服务商完成加密伪装和防被墙，免去部署维护，非常省事。  
 这里再次提醒一下，市面上的vpn服务商鱼龙混杂，随时跑路，注意安全。  
 
 ### 2. 端口代理  
 首先要有一台非大陆范围并且可以访问矿池的服务器，在这台机子上安装部署上代理软件，并配置对矿池端口的转发代理，防火墙开放暴露代理端口，然后把本地电脑挖矿内核程序调用指向这台服务器的ip和代理端口。代理软件有好多，像[`nginx`](https://nginx.org/)、`netsh`、`redir`、`TCP Mapping`等。不要安装部署那些抽水的代理软件。  
 
 ![image](https://user-images.githubusercontent.com/30925759/152676626-3bb438e6-ef85-4f37-905a-127b22f4c92a.png)   
 
 - nginx配置参考[***使用stream模块代理tcp端口***](nginx/nginx.conf)。  
 - netsh配置参考[***Netsh interface portproxy 命令***](https://docs.microsoft.com/zh-cn/windows-server/networking/technologies/netsh/netsh-interface-portproxy)。  
 - redir配置参考[***A TCP port redirector for UNIX***](https://github.com/troglobit/redir)。  
 
 不建议这样做，即使用了“**stratum+ssl**”，挖矿内核是通过跳过TLS证书有效性认证的方式通信，在ssl握手阶段和依据后期持的续流量行为特征，仍然可以识别出来。另外，挖矿内核程序会另外连接开发者的指定的矿池（一般是私有池），依然可以识别出来。  
 
 ### 3. 自建vpn科学上网  
 首先要有一台非大陆范围并且可以访问矿池的服务器，比如像我的vps，安装部署`v2ray`·、`trojan`等软件，这些软件通过C/S架构模式提供了科学上网的实现能力。  
 
 ![image](https://user-images.githubusercontent.com/30925759/152678451-e894d39d-4b3a-466a-95c5-c752e56a18b5.png)  
 
 - v2ray（*websocket+tls+web页面代理*）配置参考[***部署v2ray搭建全局代理***](科学上网/v2ray)。  
 
 这种方案要求动手能力强，需要自己维护网络。  
 
 ### 4. 手写一个端口加密中转服务  
 采用C/S架构模式，依据**socket**编程，自定义报文协议，使用数据压缩算法，使用非对称加密算法，做好流量伪装混淆机制。同样要有一台非大陆范围并且可以访问矿池的服务器，完成对矿池和开发者私池的端口中转代理，最后配合域名拦截，把挖矿内核程序调用指向C端。  
 
 不抽水的话，不建议这样做，太费事了。 
 
 ### 5. 使用oray蒲公英的智能组网  
 蒲公英组网原理有点像[zerotier](https://www.zerotier.com/)组网。首先在vps上安装[蒲公英客户端](https://pgy.oray.com/download/)和矿池代理服务，矿机这边也安装蒲公英客户端，或者使用蒲公英路由器，配置组网成功后，都在两边设备都在一个虚拟局域网中，使用虚拟ip访问vps上的矿池代理服务端口。走蒲公英服务器的转发带宽是1~2M，挖矿够用了。  
 ![image](https://user-images.githubusercontent.com/30925759/159162155-04876b4b-2111-438f-957a-11b3936823d1.png)
 
 <br>
 <br>
 最后，啊啊啊，低调上网，我们都是好孩子。  
 
 ---
 资料整理归档2022-05-16
