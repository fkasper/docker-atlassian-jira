#!/bin/bash



DEBIAN_FRONTEND=noninteractive apt-add-repository ppa:webupd8team/java -y
apt-get update -yqq
echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections

DEBIAN_FRONTEND=noninteractive apt-get install -q -y software-properties-common supervisor wget dnsutils oracle-java7-installer sudo


apt-get clean
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


FILE=atlassian-jira-6.4.11.tar.gz
URL=https://www.atlassian.com/software/jira/downloads/binary/$FILE


mkdir -p /opt/atlassian/jira

wget -qO - $URL |tar xfz - -C /opt/atlassian/jira
