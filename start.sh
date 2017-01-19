docker run --name mysql -p 3306:3306 -d -v g:/vagrant/docker/mysql/my.cnf:/etc/mysql/my.cnf -v g:/vagrant/docker/mysql/data:/var/lib/mysql -v g:/vagrant/docker/mysql/log:/var/log/mysql -e MYSQL_ROOT_PASSWORD=root1234 yidashi/mysql

docker run --name phpfpm -d -v g:/vagrant/www:/var/www/html --link mysql:mysql yidashi/php

docker run --name nginx -d -p 80:80 --link phpfpm:phpfpm -v g:/vagrant/docker/nginx/nginx.conf:/etc/nginx/nginx.conf -v g:/vagrant/docker/nginx/servers:/etc/nginx/servers -v g:/v
agrant/docker/nginx/fastcgi.conf:/etc/nginx/fastcgi.conf --volumes-from phpfpm yidashi/nginx


docker run --name mysql-3307 -p 3307:3306 -d -v g:/vagrant/docker/mysql/3307/my.cnf:/etc/mysql/my.cnf -v g:/vagrant/docker/mysql/3307/data:/var/lib/mysql  -v g:/vagrant/docker/mysql/3307/log:/var/log/mysql --link mysql:mysql -e MYSQL_ROOT_PASSWORD=root1234 yidashi/mysql

change master to master_host='mysql', master_user='root', master_password='root1234', master_port=3306, master_log_file='mysql-bin.000001', master_log_pos=0, master_connect_retry=30;

start slave;
