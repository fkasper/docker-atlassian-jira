#!/bin/bash



if [ -f /opt/atlassian/jira-home/server-shared.xml ]; then
  cp /opt/atlassian/jira-home/server-shared.xml /opt/atlassian/jira/conf/server.xml
  test -f /opt/atlassian/jira/conf/server.xml && echo "Server.xml exists"
fi

chown -R jira:jira /opt/atlassian/jira-home

export CATALINA_OPTS="$CATALINA_OPTS"

echo "using catalina with the following options:"
echo
echo "$CATALINA_OPTS"

/usr/bin/supervisord
