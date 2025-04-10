FROM php:7.4-apache

# Install ekstensi PHP yang dibutuhkan CodeIgniter
RUN docker-php-ext-install mysqli pdo pdo_mysql

# Copy semua isi project ke /var/www/html
COPY . /var/www/html

# Aktifkan mod_rewrite (buat routing CodeIgniter)
RUN a2enmod rewrite

# Ubah permissions (opsional)
RUN chown -R www-data:www-data /var/www/html

# Enable error reporting (opsional saat dev)
ENV PHP_DISPLAY_ERRORS=On
