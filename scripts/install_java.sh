#!/usr/bin/env bash

echo "Installing Java..."
mkdir -p /opt/java/1.8.0_40/
wget --quiet --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u40-b25/jdk-8u40-linux-x64.tar.gz" -O /opt/java/1.8.0_40/jdk-8u40-linux-x64.tar.gz
tar xzf /opt/java/1.8.0_40/jdk-8u40-linux-x64.tar.gz -C /opt/java/1.8.0_40/ --strip 1

sudo echo "JAVA_HOME=/opt/java/1.8.0_40/" >> /etc/environment
# add to PATH
escaped_java_home=$(echo "/opt/java/1.8.0_40/" | sed 's/\//\\\//g')
sed -i "s/\(^PATH.*\)\"$/\1:${escaped_java_home}\/bin\"/" /etc/environment
# clear up source
rm /opt/java/1.8.0_40/jdk-8u40-linux-x64.tar.gz
