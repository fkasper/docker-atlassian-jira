#!/bin/bash

BASE=/opt/atlassian/jira/atlassian-jira-6.4.11-standalone

echo "Starting Jira. Searching for server-shared.xml"

echo "ENV:"
env

JIRA_HOME=/opt/atlassian/jira-home


echo
echo "Checking for default config"
echo
echo "------------------------------"
echo "Postgres(Kubernetes and SkyDNS only):"
POSTGRES=$(nslookup postgres |grep -E 'Address\s\d+?:\s(.*)'|tail -n1|awk -F': ' '{print $2}')
echo "  IP: $POSTGRES"
echo "  PORT: $POSTGRES_SERVICE_PORT"
echo "  USER: postgres"
echo "  PASS: $DB_PASS"
echo "------------------------------"
echo 

if [ "$(ls -A $JIRA_HOME)" ]; then
  echo "JIRA-home not empty."
else
  curl -LSs \
    "https://www.dropbox.com/s/m80jqqzvplzeuqn/atlassian-jira-sample-home-6.4.11.gz?raw=1" | \
    sudo tar xfz - -C $JIRA_HOME/
fi

if [ -f /opt/atlassian/jira-home/server-shared.xml ]; then
  echo "JIRA Server XML exists"
  cp /opt/atlassian/jira-home/server-shared.xml $BASE/conf/server.xml
  test -f $BASE/conf/server.xml && echo "Server.xml exists"
fi
echo "Proxying: $PROXY_SCHEME://$PROXY_HOST:$PROXY_PORT"

if [ ! -z $PROXY_HOST ]; then
  sed -i "s#<Connector port=\"8080\"#<Connector port=\"8080\"\n            proxyName=\"$PROXY_HOST\"#" $BASE/conf/server.xml
fi

if [ ! -z $PROXY_PORT ]; then
  sed -i "s#<Connector port=\"8080\"#<Connector port=\"8080\"\n            proxyPort=\"$PROXY_PORT\"#" $BASE/conf/server.xml
fi

if [ ! -z $PROXY_SCHEME ]; then
  sed -i "s#<Connector port=\"8080\"#<Connector port=\"8080\"\n            scheme=\"$PROXY_SCHEME\"#" $BASE/conf/server.xml
fi

cat $BASE/conf/server.xml

chown -R jira:jira $JIRA_HOME

export CATALINA_OPTS="$CATALINA_OPTS"


echo "using catalina with the following options:"
echo
echo "$CATALINA_OPTS"

$BASE/bin/start-jira.sh -fg

