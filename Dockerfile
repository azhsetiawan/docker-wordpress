FROM wordpress:php5.6

RUN apt-get update \
  && apt-get install -y --no-install-recommends ssl-cert \
  && apt-get install -y sudo less mysql-client \
  && rm -rf /var/lib/apt/lists/*

RUN a2enmod ssl
RUN a2ensite default-ssl

# WP-CLI 
# to install latest version WP-CLI, uncomment line below and comment line 14
# RUN curl -o /bin/wp-cli.phar https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
COPY ./wpcli/wp-cli.phar /bin/wp-cli.phar

RUN chmod +x /bin/wp-cli.phar
COPY ./wpcli/wp-su.sh /bin/wp
RUN chmod +x /bin/wp

EXPOSE 80 443