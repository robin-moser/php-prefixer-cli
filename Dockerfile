FROM php:7.4-alpine as build
COPY --from=composer:2.4 /usr/bin/composer /usr/bin/composer

WORKDIR /app
ADD . /app

RUN composer install && \
	./php-prefixer-cli app:build --no-ansi --no-interaction

FROM php:7.4-alpine
COPY --from=build /app/builds/php-prefixer-cli /usr/local/bin/

ENTRYPOINT [ "/usr/local/bin/php-prefixer-cli" ]
