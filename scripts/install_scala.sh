#!/usr/bin/env bash

echo "Installing Scala"

mkdir -p /opt/scala/2.11.4/
wget --quiet http://downloads.typesafe.com/scala/2.11.4/scala-2.11.4.tgz -O /opt/scala/2.11.4/scala-2.11.4.tgz
tar xf /opt/scala/2.11.4/scala-2.11.4.tgz -C /opt/scala/2.11.4/ --strip 1
echo "SCALA_HOME=/opt/scala/2.11.4/" >> /etc/environment
# add to PATH
escaped_scala_home=$(echo "/opt/scala/2.11.4" | sed 's/\//\\\//g')
sed -i "s/\(^PATH.*\)\"$/\1:${escaped_scala_home}\/bin\"/" /etc/environment
rm /opt/scala/2.11.4/scala-2.11.4.tgz
