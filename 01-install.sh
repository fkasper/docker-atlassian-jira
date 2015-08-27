#!/bin/bash



DEBIAN_FRONTEND=noninteractive apt-get install -q -y software-properties-common
DEBIAN_FRONTEND=noninteractive apt-add-repository ppa:webupd8team/java -y
apt-get update

echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
DEBIAN_FRONTEND=noninteractive apt-get install oracle-java7-installer -y

apt-get update -yqq
apt-get install -yqq supervisor wget
apt-get clean
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


FILE=atlassian-jira-6.4.11-x64.bin
URL=https://www.atlassian.com/software/jira/downloads/binary/$FILE


wget -q $URL

chmod +x $FILE
cat > ~/response.varfile <<EOL
sys.installationDir=/opt/atlassian/jira
app.jiraHome=/opt/atlassian/jira-home
app.install.service$Boolean=false
EOL
./$FILE -q -varfile ~/response.varfile

rm $FILE
rm -rf /tmp /var/tmp 
