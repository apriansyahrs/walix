FROM php:7.4-fpm

# Install ekstensi PHP yang dibutuhkan CodeIgniter
RUN docker-php-ext-install mysqli pdo pdo_mysql

# Copy project ke container
COPY . /var/www/html

# Set working directory
WORKDIR /var/www/html

# Set permissions (opsional)
RUN chown -R www-data:www-data /var/www/html

# Optional: aktifkan error reporting (dev only)
RUN echo "display_errors=On" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
 && echo "error_reporting=E_ALL" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

# Copy custom nginx config
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Install Nginx
RUN apt-get update && apt-get install -y nginx

# Expose port default nginx
EXPOSE 80

# Start script untuk Nginx + PHP-FPM
CMD service php7.4-fpm start && nginx -g 'daemon off;'
