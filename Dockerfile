FROM phusion/baseimage

MAINTAINER Florian Kasper <florian@xpandmmi.com>

COPY 01-install.sh /install
RUN /install

COPY jira-application.properties /opt/atlassian/jira/atlassian-jira-6.4.11-standalone/atlassian-jira/WEB-INF/classes/jira-application.properties


COPY 02-start.sh /start

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 8080 8015
VOLUME /opt/atlassian/jira-home

CMD ["sh", "-c", "/start"]
