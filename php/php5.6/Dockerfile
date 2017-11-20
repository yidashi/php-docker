FROM php:5.6-fpm
# Install modules
RUN mv /etc/apt/sources.list /etc/apt/sources.list.bak && \
    echo "deb http://mirrors.aliyun.com/debian/ jessie main non-free contrib" >/etc/apt/sources.list && \
    echo "deb http://mirrors.aliyun.com/debian/ jessie-proposed-updates main non-free contrib" >>/etc/apt/sources.list && \
    echo "deb-src http://mirrors.aliyun.com/debian/ jessie main non-free contrib" >>/etc/apt/sources.list && \
    echo "deb-src http://mirrors.aliyun.com/debian/ jessie-proposed-updates main non-free contrib" >>/etc/apt/sources.list && apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
    && docker-php-ext-install iconv mcrypt \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd && docker-php-ext-install mysql && docker-php-ext-install mbstring \
    && docker-php-ext-install pcntl  && docker-php-ext-install pdo_mysql && docker-php-ext-install mysqli
CMD ["php-fpm"]
