FROM nginx:alpine AS builder

RUN apk add --no-cache --virtual .build-deps \
        wget git gcc make gnupg \
        libc-dev openssl-dev pcre-dev zlib-dev linux-headers libxslt-dev gd-dev geoip-dev

WORKDIR /usr/src
RUN wget http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz -O nginx.tar.gz && \
    git clone --depth 1 https://github.com/aperezdc/ngx-fancyindex.git ngx-fancyindex && \
    git clone --depth 1 https://github.com/Naereen/Nginx-Fancyindex-Theme.git ngx-fancyindex-theme && \
    tar xzf nginx.tar.gz && \
    cd nginx-${NGINX_VERSION} && \
    CONFARGS=$(nginx -V 2>&1 | sed -n -e 's/^.*arguments: //p') \
    ./configure --with-compat $CONFARGS --add-dynamic-module=../ngx-fancyindex && \
    make && \
    make install

FROM nginx:alpine

COPY --from=builder /usr/local/nginx/modules/ngx_http_fancyindex_module.so /usr/local/nginx/modules/ngx_http_fancyindex_module.so
COPY --from=builder /usr/src/ngx-fancyindex-theme/Nginx-Fancyindex-Theme-light /usr/share/nginx/Nginx-Fancyindex-Theme-light
COPY --from=builder /usr/src/ngx-fancyindex-theme/Nginx-Fancyindex-Theme-dark /usr/share/nginx/Nginx-Fancyindex-Theme-dark
COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80
STOPSIGNAL SIGTERM
CMD ["nginx", "-g", "daemon off;"]
