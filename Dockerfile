FROM phusion/baseimage

MAINTAINER Florian Kasper <florian@xpandmmi.com>

COPY 01-install.sh /install
RUN /install

COPY 02-start.sh /start

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 8080 8015
VOLUME /opt/atlassian/jira-home

CMD ["sudo", "/start"]
