FROM openresty/openresty:buster

RUN apt-get update -y && apt-get install -y curl unzip \
    && curl -fLO https://github.com/spirius/fc/releases/download/v2.1.1/gofc_linux_amd64.zip \
    && unzip gofc_linux_amd64.zip && mv gofc /usr/local/bin/gofc \
    && rm -rf /var/lib/apt/lists/* gofc_linux_amd64.zip

ADD /nginx.tpl.conf .
ADD /entrypoint.sh .

ENTRYPOINT ["/entrypoint.sh"]
