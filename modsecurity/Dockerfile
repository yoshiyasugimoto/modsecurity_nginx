FROM nginx:1.19.9

RUN rm /var/log/nginx/access.log && rm /var/log/nginx/error.log && nginx
RUN apt-get update && \
    apt-get install -y \
        apt-utils autoconf automake build-essential \
        git libcurl4-openssl-dev libgeoip-dev liblmdb-dev \
        libpcre++-dev libtool libxml2-dev libyajl-dev \
        pkgconf wget zlib1g-dev jq vim
RUN apt-get install -y --no-install-recommends apache2-utils
RUN cd 
RUN git clone --depth 1 -b v3.0.4 --single-branch https://github.com/SpiderLabs/ModSecurity
WORKDIR ./ModSecurity 
RUN git submodule init && git submodule update
RUN ./build.sh && ./configure
RUN make && make install
RUN mkdir -p /etc/nginx/modsecurity
RUN cp modsecurity.conf-recommended /etc/nginx/modsecurity/modsecurity.conf
RUN cp unicode.mapping /etc/nginx/modsecurity

WORKDIR ../
RUN git clone --depth 1 https://github.com/SpiderLabs/ModSecurity-nginx.git

RUN wget http://nginx.org/download/nginx-1.19.9.tar.gz
RUN tar zxvf nginx-1.19.9.tar.gz
WORKDIR nginx-1.19.9 
RUN ./configure --with-compat --add-dynamic-module=../ModSecurity-nginx
RUN make modules

RUN cp objs/ngx_http_modsecurity_module.so /etc/nginx/modules  
RUN sed -i -e '6a load_module modules/ngx_http_modsecurity_module.so;' /etc/nginx/nginx.conf 

COPY conf.d/main.conf /etc/nginx/modsecurity/main.conf
COPY conf.d/default.conf /etc/nginx/conf.d/default.conf

# RUN htpasswd -c /etc/nginx/htpasswd username
RUN /bin/sh -c nginx -s reload
