# Dockerfile

# https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#run

# use Debian Buster
FROM debian:buster

# update system to prevent errors
# install MariaDB Server
# remove apt list cache to prevent errors
# https://websetnet.net/fixing-unable-to-parse-package-file-var-lib-apt-lists-error-in-ubuntu-and-other-linux-distributions/
RUN apt-get update -y && apt-get install -y \
    mariadb-server \
    &&  rm -rf /var/lib/apt/lists/*

# copy own mariadb config file into container from host VM
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# expose args from .env to .yml for setting up MariaDB user (only used with .sh script)
ARG MDB_HOST=${MDB_HOST}
ARG MDB_NAME=${MDB_NAME}
ARG MDB_PASS=${MDB_PASS}
ARG MDB_PASS_ROOT=${MDB_PASS_ROOT}
ARG MDB_USER=${MDB_USER}

# copy setup instruction for databank to container & run setup
COPY tools/setup.sql /setup.sql
RUN service mysql start ; \
   mysql < setup.sql ; \
   rm -rf setup.sql
# COPY tools/setup.sh /setup.sh
# RUN bash setup.sh ; \
#    rm -rf setup.sh

# port 3306 container listens to at runtime
EXPOSE 3306

# https://man7.org/linux/man-pages/man1/mysqld_safe.1.html
# https://devtron.ai/blog/cmd-and-entrypoint-differences/#:~:text=Differences%20between%20CMD%20%26%20ENTRYPOINT&text=CMD%20commands%20are%20ignored%20by,as%20arguments%20of%20the%20command.
CMD ["mysqld_safe"]
