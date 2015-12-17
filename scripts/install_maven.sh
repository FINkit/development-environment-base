#!/usr/bin/env bash

echo "Installing Maven"

mkdir -p /opt/maven/3.2.5/
wget --quiet http://apache.crihan.fr/dist/maven/maven-3/3.2.5/binaries/apache-maven-3.2.5-bin.tar.gz -O /opt/maven/3.2.5/apache-maven-3.2.5-bin.tar.gz
tar xf /opt/maven/3.2.5/apache-maven-3.2.5-bin.tar.gz -C /opt/maven/3.2.5/ --strip 1
echo "M2_HOME=/opt/maven/3.2.5/" >> /etc/environment
echo "M2=/opt/maven/3.2.5/bin" >> /etc/environment
echo "M2_OPTS=\"-Xms256m -Xmx512m\"" >> /etc/environment
# add to PATH
escaped_maven_home=$(echo "/opt/maven/3.2.5/" | sed 's/\//\\\//g')
sed -i "s/\(^PATH.*\)\"$/\1:${escaped_maven_home}\/bin\"/" /etc/environment
rm /opt/maven/3.2.5/apache-maven-3.2.5-bin.tar.gz
