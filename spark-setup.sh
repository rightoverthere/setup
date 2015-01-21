#spark

#http://d3kbcqa49mib13.cloudfront.net/spark-1.1.1-bin-hadoop2.4.tgz

wget http://www.us.apache.org/dist/spark/spark-1.1.1/spark-1.1.1.tgz

sudo tar -xzvf spark-1.1.1.tgz

sudo mv spark-1.1.1 /usr/local/

cd /usr/local

ln -s spark-1.1.1/ spark

cd spark

mvn -Phadoop-2.6 -Dhadoop.version=2.6.0 -DskipTests clean package

echo "export SPARK_HOME=/usr/local/spark" | sudo tee -a /etc/bash.bashrc
echo 'export PATH=$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin' | sudo tee -a /etc/bash.bashrc 

# set HADOOP_CONF_DIR in spark-env.sh.template

