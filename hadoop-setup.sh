: '
setup-hadoop
'

mkdir setup
cd setup

wget http://www.us.apache.org/dist/hadoop/common/stable2/hadoop-2.6.0.tar.gz

tar -xvf hadoop-2.6.0.tar.gz
mv hadoop-2.6.0 /usr/local
cd /usr/local
ln -s hadoop-2.6.0 hadoop

whereis hadoop


sudo addgroup hadoop
sudo adduser --ingroup hadoop hduser
sudo adduser hduser sudo
sudo chown -R hduser:hadoop /usr/local/hadoop/

# also do for dan
su - hduser
ssh-keygen -t rsa -P ""
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

echo "net.ipv6.conf.all.disable_ipv6 = 1" | sudo tee -a /etc/sysctl.conf
echo "net.ipv6.conf.default.disable_ipv6 = 1" | sudo tee -a /etc/sysctl.conf
echo "net.ipv6.conf.lo.disable_ipv6 = 1" | sudo tee -a /etc/sysctl.conf

# restart / reboot

echo "export HADOOP_HOME=/usr/local/hadoop" | sudo tee -a /etc/bash.bashrc
echo 'export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop' | sudo tee -a /etc/bash.bashrc
echo 'export PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin' | sudo tee -a /etc/bash.bashrc 

su - hduser
mkdir /usr/local/hadoop/data

cd /usr/local/hadoop/etc/hadoop

# vi hadoop-env.sh
# change JAVA_HOME /usr/lib/jvm/default-java
# change:  export HADOOP_OPTS="$HADOOP_OPTS -Djava.net.preferIPv4Stack=true -Djava.library.path=$HADOOP_PREFIX/lib/native"
# add: export HADOOP_COMMON_LIB_NATIVE_DIR=${HADOOP_PREFIX}/lib/native


# vi yarn-env.sh
# add: export HADOOP_CONF_LIB_NATIVE_DIR=${HADOOP_PREFIX:-"/lib/native"}
# add: export HADOOP_OPTS="-Djava.library.path=$HADOOP_PREFIX/lib/native"

# vi core-site.xml
# add:
:'
<property>
  <name>fs.default.name</name>
  <value>hdfs://localhost:9000</value>
</property>
<property>
  <name>hadoop.tmp.dir</name>
  <value>/usr/local/hadoop/data</value>
</property>
'

# vi hdfs-site.xml
# add

:'
    <property>
        <name>mapreduce.framework.name</name>
        <value>yarn</value>
    </property>

  <property>
    <name>dfs.permissions</name>
    <value>false</value>
  </property>
' 



# vi yarn-site,xml
# add

:'
    <property>
        <name>yarn.nodemanager.aux-services</name>
        <value>mapreduce_shuffle</value>
    </property>
    <property>
        <name>yarn.nodemanager.aux-services.mapreduce_shuffle.class</name>
        <value>org.apache.hadoop.mapred.ShuffleHandler</value>
    </property>
    <property>
        <name>yarn.resourcemanager.resource-tracker.address</name>
        <value>localhost:8025</value>
    </property>
    <property>
        <name>yarn.resourcemanager.scheduler.address</name>
        <value>localhost:8030</value>
    </property>
    <property>
        <name>yarn.resourcemanager.address</name>
        <value>localhost:8050</value>
    </property>
'


# add to /etc/bash.bashrc

# export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native
# export HADOOP_OPTS="-Djava.library.path=$HADOOP_HOME/lib/native"

hdfs namenode -format

start-dfs.sh

start-yarn.sh



