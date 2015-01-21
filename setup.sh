#setup sh
cd ~/setup

export DEBIAN_FRONTEND=noninteractive

#sudo apt-get -q -y install vim
apt-get -q -y install default-jdk
apt-get -q -y install maven
apt-get -q -y install ssh
apt-get -q -y install svn
apt-get -q -y install git
apt-get -q -y install curl

apt-get -q -y install avahi-daemon
update-rc.d -q -y avahi-daemon defaults

echo "export JAVA_HOME=/usr/lib/jvm/default-java"| sudo tee -a /etc/bash.bashrc

apt-get remove scala-library scala
wget www.scala-lang.org/files/archive/scala-2.10.4.deb
dpkg -i scala-2.10.4.deb
apt-get update
apt-get install scala

wget http://scalasbt.artifactoryonline.com/scalasbt/sbt-native-packages/org/scala-sbt/sbt/0.12.4/sbt.deb
dpkg -i sbt.deb
apt-get update
apt-get install sbt 


