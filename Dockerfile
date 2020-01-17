FROM ubuntu:18.04
LABEL maintainer="tingluohuang@github.com"

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y squid apache2-utils \
 && rm -rf /var/lib/apt/lists/*

RUN htpasswd -b -c /etc/squid/users_passwd github actions
RUN sed -i '1iauth_param basic program /usr/lib/squid/basic_ncsa_auth /etc/squid/users_passwd' /etc/squid/squid.conf
RUN sed -i '2iacl auth_users proxy_auth REQUIRED' /etc/squid/squid.conf
RUN sed -i '3ihttp_access allow auth_users' /etc/squid/squid.conf

COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh

EXPOSE 3128/tcp
ENTRYPOINT ["/sbin/entrypoint.sh"]
