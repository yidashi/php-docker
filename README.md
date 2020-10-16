# php-docker

docker-compose一键安装php+mysql+nginx+redis环境

1、复制一个.env.example文件存为.env，里边的两个地址分别对应你自己的www目录和这个项目的根目录

2、进入docker文件夹，执行log权限为777
chmod -R 777 docker/mysql/log

3、安装
docker-compose up -d
