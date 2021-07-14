FROM nginx:1.19.9

RUN rm /var/log/nginx/access.log && rm /var/log/nginx/error.log
RUN apt-get update && \
    apt-get install -y \
        apt-utils autoconf automake build-essential \
        git libcurl4-openssl-dev libgeoip-dev liblmdb-dev \
        libpcre++-dev libtool libxml2-dev libyajl-dev \
        pkgconf wget zlib1g-dev jq vim
RUN cd 
RUN git clone --depth 1 -b v3.0.4 --single-branch https://github.com/SpiderLabs/ModSecurity
WORKDIR ./ModSecurity 
RUN git submodule init && git submodule update
RUN ./build.sh && ./configure
RUN make && make install
RUN mkdir -p /etc/nginx/modsecurity
RUN cp modsecurity.conf-recommended /etc/nginx/modsecurity/modsecurity.conf
RUN cp unicode.mapping /etc/nginx.modsecurity