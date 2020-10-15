ARG PHP_VER

# 镜像包
FROM php:${PHP_VER}

# ARG SWOOLE_VER
# ARG COMPOSER_URL

# 设置时区为上海
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Ubuntu软件源选择中国的服务器（php7.2报找不到/etc/apt/sources.list）
RUN sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list

# 更新安装依赖包
RUN apt-get update && apt-get install -y \
        git \
        vim \
        curl \
        wget \
        openssl \
        imagemagick \
        libmagickwand-dev \
        libmagickcore-dev \
        libzip-dev \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        libxml2-dev \
		libssl-dev \
		librabbitmq-dev

# 安装PHP核心拓展
RUN docker-php-ext-install \
        pdo_mysql \
        opcache \
        mysqli \
        intl \
        exif \
        zip \
        bcmath \
	&& docker-php-ext-configure gd \
        --with-freetype-dir=/usr/include/ \
        --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && rm -r /var/lib/apt/lists/*

# pecl安装amqp、mongodb、redis、xlswriter扩展
RUN pecl install -o -f mongodb amqp redis xlswriter imagick swoole  \
    && rm -rf /tmp/pear

# 加入php扩展
RUN docker-php-ext-enable mongodb amqp redis xlswriter imagick swoole

# # php swoole扩展
# RUN cd /usr/src \
#     && pecl download swoole-${SWOOLE_VER} \
#     && tar -zxvf swoole-${SWOOLE_VER}.tgz \
#     && cd swoole-${SWOOLE_VER} \
#     && phpize \
#     && ./configure --with-php-config=/usr/local/bin/php-config --enable-openssl \
#     && make \
#     && make install \
#     && echo "extension=swoole.so" > /usr/local/etc/php/conf.d/swoole.ini \
#     && rm -rf swoole-${SWOOLE_VER}.tgz \
#     && rm -rf swoole-${SWOOLE_VER}

# # 安装 Composer
# ENV COMPOSER_HOME /root/composer
# RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
# ENV PATH $COMPOSER_HOME/vendor/bin:$PATH
# RUN composer config -g repo.packagist composer ${COMPOSER_URL}
# RUN composer global require "fxp/composer-asset-plugin:^1.4.0"

# Install composer and change it's cache home
RUN curl -o /usr/bin/composer https://mirrors.aliyun.com/composer/composer.phar \
    && chmod +x /usr/bin/composer
ENV COMPOSER_HOME=/tmp/composer

# 1.0.24 增加 odbc, pdo_odbc 扩展   
RUN set -ex; \  
docker-php-source extract; \  
{ \  
     echo '# https://github.com/docker-library/php/issues/103#issuecomment-271413933'; \  
     echo 'AC_DEFUN([PHP_ALWAYS_SHARED],[])dnl'; \  
     echo; \  
     cat /usr/src/php/ext/odbc/config.m4; \  
} > temp.m4; \  
mv temp.m4 /usr/src/php/ext/odbc/config.m4; \  
apt-get update; \  
apt-get install -y --no-install-recommends unixodbc-dev; \  
rm -rf /var/lib/apt/lists/*; \  
docker-php-ext-configure odbc --with-unixODBC=shared,/usr; \  
docker-php-ext-configure pdo_odbc --with-pdo-odbc=unixODBC,/usr; \  
docker-php-ext-install odbc pdo_odbc; \  
docker-php-source delete 


CMD ["php-fpm"]
