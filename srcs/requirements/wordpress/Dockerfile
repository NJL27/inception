# https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#run

# use Debian Buster
FROM debian:buster

# update system to prevent errors
# install curl & mariadb-client & php 7.3 incl. fpm & mysql
# remove apt list cache to prevent errors
# https://websetnet.net/fixing-unable-to-parse-package-file-var-lib-apt-lists-error-in-ubuntu-and-other-linux-distributions/
RUN apt-get update -y && apt-get install -y \
    curl \
    mariadb-client \
    php7.3-fpm \
    php7.3-mysql \
&&  rm -rf /var/lib/apt/lists/*

# copy own php config file to container from host VM
# https://myjeeva.com/php-fpm-configuration-101.html
RUN mkdir -p /etc/php/7.3/fpm
COPY conf/www.conf /etc/php/7.3/fpm/pool.d

RUN mkdir /run/php

# install WordPress Commandline tool & rename from wp-cli to wp & add execution rights to use it
# https://code.tutsplus.com/articles/download-and-install-wordpress-via-the-shell-over-ssh--wp-24403
# https://www.dreamhost.com/blog/guide-to-wp-cli/#:~:text=The%20WP%2DCLI%20is%20a,faster%20using%20the%20WP%2DCLI
# https://wordpress.stackexchange.com/questions/293124/shortest-way-to-install-wp-cli
RUN	curl https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar --output /usr/bin/wp --silent && \
    chmod +x ./usr/bin/wp

# port 9000 container listens to at runtime
EXPOSE 9000

# copy configuration script
# give execution rights to launch locally
# use as entrypoint for container
COPY ./conf/config.sh /var/www/wordpress/config.sh
RUN chmod +x /var/www/wordpress/config.sh
ENTRYPOINT ["/var/www/wordpress/config.sh"]
