@echo off
echo nginx-v2ray startup ...
title nginx-v2ray---start
set NGINX_ENV_HOME="C:\brucezhang\nginx-1.20.2"
set V2RAY_ENV_HOME="C:\brucezhang\v2ray-windows-64"

color 0a
echo=  
echo 1----nginx path: %NGINX_ENV_HOME%
%NGINX_ENV_HOME%\nginx.exe -v
echo 1----����nginx����
TASKKILL /IM nginx.exe /T /F 
echo 1----����nginx�������
echo 1----����nginx
start "" /d %NGINX_ENV_HOME% "nginx.exe"
echo 1----����nginx���
echo=  
timeout /t 2 /nobreak > NUL
echo 2----v2ray path: %V2RAY_ENV_HOME%
%V2RAY_ENV_HOME%\v2ray.exe version
echo 2----����v2ray����
tskill v2ray 
echo 2----����v2ray�������
echo 2----����v2ray
start "v2ray" /d %V2RAY_ENV_HOME% v2ray.exe run
echo 2----����v2ray���
echo nginx-v2ray startup completed
echo=

pause
exit