FROM wordpress:latest

# ARGS
ARG YOUR_UID

RUN groupmod -g ${YOUR_UID} www-data
RUN usermod -u ${YOUR_UID} www-data
RUN chown -R www-data:www-data /usr/src/wordpress