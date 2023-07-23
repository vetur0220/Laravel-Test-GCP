# 使用指定版本的 PHP 映像作為基礎映像
FROM php:8.1.21-fpm

# 安裝所需的套件和擴展
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libzip-dev \
    zip \
    unzip \
    git \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd pdo pdo_mysql zip

# 設定工作目錄
WORKDIR /var/www

# 將 Laravel 專案複製到容器中
COPY . .

# 安裝 Composer 並執行相依套件安裝
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer install

# 定義容器運行時的指令
CMD ["php", "artisan", "serve", "--host=0.0.0.0"]
