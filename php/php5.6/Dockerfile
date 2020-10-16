FROM php:5.6-fpm
# Install modules
COPY ./sources.list.stretch   /etc/apt/sources.list

RUN apt-get update
## mcrypt-dev  GD   依赖文件
RUN  apt-get install -y libmcrypt-dev \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng-dev  
## GD   
RUN docker-php-ext-install    gd pdo_mysql  mysql  mysqli

CMD ["php-fpm"]
