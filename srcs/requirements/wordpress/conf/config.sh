#!/bin/bash

# 'wp core config' create wp-config.php file & configure wp instance to accept MariaDB databank
# 'wp core install' install wp instance & set admin user & general infos like title & url
# create first non-admin user
# https://www.youtube.com/watch?v=9E1lyVyh4xc
# https://wordpress.org/support/article/creating-database-for-wordpress/#using-the-mysql-client
cd /var/www/wordpress

wp core download --allow-root

wp core config \
				--dbname=$WP_DB_NAME \
				--dbuser=$WP_DB_USER \
				--dbpass=$WP_DB_PASS \
                --dbhost=$WP_DB_HOST \
				--allow-root

wp core install \
				--url=$WP_URL \
                --title=$WP_TITLE \
				--admin_user=$WP_ADMIN_USER \
				--admin_password=$WP_ADMIN_PASS \
				--admin_email=$WP_ADMIN_MAIL \
				--allow-root

wp user create \
                $WP_USER \
                $WP_USER_MAIL \
                --role=author \
                --user_pass=$WP_USER_PASS \
                --allow-root

cd -

# Start php-fpm to respond to FastCGI requests & force it to stay in foreground
php-fpm7.3 -F