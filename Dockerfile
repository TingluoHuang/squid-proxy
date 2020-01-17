FROM ubuntu:18.04
LABEL maintainer="tingluohuang@github.com"

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y squid \
 && rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh

EXPOSE 3128/tcp
ENTRYPOINT ["/sbin/entrypoint.sh"]
