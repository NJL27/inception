# https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#run

# use Debian Buster
FROM debian:buster

# update system to prevent errors
# install ngix & openssl
# removes apt list cache to prevent errors
# https://websetnet.net/fixing-unable-to-parse-package-file-var-lib-apt-lists-error-in-ubuntu-and-other-linux-distributions/
RUN apt-get update -y && apt-get install -y \
    nginx \
    openssl \
&&  rm -r /var/lib/apt/lists/*

# copy own mariadb config file to container from host VM
COPY conf/nginx.conf /etc/nginx/sites-available/default

# https://www.linode.com/docs/guides/create-a-self-signed-tls-certificate/
# https://www.openssl.org/docs/man1.0.2/man1/openssl-req.html
# openssl req -newkey rsa:4096: Creates 4096 bit RSA key with TLS certificate
# -x509: creates a self signed certificate
# -days n: number of days the certificate is valid for
# -sha256: encryption algorithm for certificate request
# -nodes: NO passphrase for private key required
# -out filename: where to write output to. Default = standard output
# -keyout filename: where to write newly created private key to
# -subj arg: set subject name for requests to arg. 'CN' = Common Name
RUN openssl req -newkey rsa:4096 \
    -x509 -days 365 \
    -sha256 -nodes \
    -out /etc/ssl/certs/nginx.crt \
    -keyout /etc/ssl/private/nginx.key \
    -subj "/CN=nlenoch.42.fr"

# port 443 as only bridge between www & webserver
EXPOSE 443

# https://itecnote.com/tecnote/docker-the-difference-between-nginx-daemon-on-off-option/
# https://hub.docker.com/_/nginx/
CMD ["nginx", "-g", "daemon off;"]