#mahout setup

cd setup

git clone https://github.com/apache/mahout.git

mv mahout /usr/local/

cd /usr/local/mahout

mvn -DskipTests clean install

echo 'export MAHOUT_HOME=/usr/local/mahout' | sudo tee -a /etc/bash.bashrc
echo 'export PATH=$PATH:$MAHOUT_HOME/bin' | sudo tee -a /etc/bash.bashrc


