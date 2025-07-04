#!/bin/bash
 Instalacao Terrafor
echo "# Instalacao Terraform, Iniciada..." >>/home/ubuntu/AndamentoUserData.Terraform
sudo mkdir /home/ubuntu/Install
# mkdir /home/ubuntu/IaC
sudo mkdir /home/ubuntu/Projeto
sudo mkdir /home/ubuntu/Projeto/Docker
sudo mkdir /home/ubuntu/Projeto/Terraform
cd /home/ubuntu
sudo mkdir Data
sudo chown -R ubuntu:ubuntu *

# Instalacao CLI AWS
echo "# Instalacao AWS Cli, Iniciada..." >>/home/ubuntu/AndamentoUserData.Terraform
cd /home/ubuntu/Install
# Amazon Linux
#curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
#unzip awscliv2.zip
#sudo ./aws/install

# https://www.youtube.com/watch?v=PLG--ieltJE
echo "# Instalacao AWS Cli, Terminada" >>/home/ubuntu/AndamentoUserData.Terraform
echo "---------------------------------" >>/home/ubuntu/AndamentoUserData.Terraform

# Acesso SSM
echo "# Instalacao AWS SSN, Iniciada..." >>/home/ubuntu/AndamentoUserData.Terraform
mkdir /tmp/ssm
cd /tmp/ssm
wget https://s3.us-east-1.amazonaws.com/amazon-ssm-us-east-1/latest/debian_amd64/amazon-ssm-agent.deb
#wget https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/debian_amd64/amazon-ssm-agent.deb
dpkg -i amazon-ssm-agent.deb
systemctl status amazon-ssm-agent
systemctl enable amazon-ssm-agent
systemctl start amazon-ssm-agent

# Ubuntu
apt install awscli -y

# Utilitarios
apt install net-tools -y

chown -R ubuntu:ubuntu /home/ubuntu/*
echo "# Instalacao AWS SSM, Terminada" >>/home/ubuntu/AndamentoUserData.Terraform
echo "---------------------------------" >>/home/ubuntu/AndamentoUserData.Terraform

# Copiando Chaves de Acesso
#cd /home/ubuntu/IaC/
#aws s3 cp s3://crfjunior/Projeto14/IaC/aws-key .

# Acesso GIT
echo "# Instalacao GIT, Iniciada..." >>/home/ubuntu/AndamentoUserData.Terraform
add-apt-repository ppa:git-core/ppa
apt-get update && apt-get -y install git
echo "# Instalacao GIT, Terminada" >>/home/ubuntu/AndamentoUserData.Terraform
echo "---------------------------------" >>/home/ubuntu/AndamentoUserData.Terraform

# Recursos EFS
#https://github.com/aws/efs-utils?tab=readme-ov-file#on-other-linux-distributions
apt update -y
apt install nfs-common -y
apt -y install binutils rustc cargo pkg-config libssl-dev
cd /home/ubuntu/Install
git clone https://github.com/aws/efs-utils
#it clone https://github.com/aws/efs-utils
cd efs-utils
./build-deb.sh
apt -y install ./build/amazon-efs-utils*deb
#apt-get -y install ./build/amazon-efs-utils*deb


cd /home/ubuntu/Projeto/Terraform
#Usar o Git para faser o Push
#cd /home/ubuntu/Projeto/Terraform/
git clone https://github.com/crfjunior65/Projeto20G6.git
cd /home/ubuntu/Projeto/Docker
#cd /home/ubuntu/Projeto/Terraform/
#git clone https://github.com/crfjunior65/Projeto20G6.git
#Usar o Git Para fazer Push

###########
###########
##### Repositório #####
cd /home/ubuntu/Install
wget https://repo.zabbix.com/zabbix/6.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_6.0-4+ubuntu22.04_all.deb
sudo dpkg -i zabbix-release_6.0-4+ubuntu22.04_all.deb

sudo apt update
sudo apt install htop
#sudo apt install -y zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-sql-scripts zabbix-agent mariadb-server
#sudo apt install -y zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-sql-scripts zabbix-agent mysql-server
sudo apt install -y mysql-server
sudo systemctl start mysql

##### MariaDB #####
#sudo systemctl start mariadb

##### Ajustes no BD #####

############sudo mysql -h${ZABBIX_DB_SERVER} -u${ZABBIX_DB_USER} -p${ZABBIX_DB_PASS} -e "create database ${ZABBIX_DB_NAME} character set utf8mb4 collate utf8mb4_bin"
sudo mysql -h${ZABBIX_DB_SERVER} -u${ZABBIX_DB_USER} -p${ZABBIX_DB_PASS} -e "create user '${ZABBIX_DB_USER}'@'${ZABBIX_DB_SERVER}' identified by '${ZABBIX_DB_PASS}'"
sudo mysql -h${ZABBIX_DB_SERVER} -u${ZABBIX_DB_USER} -p${ZABBIX_DB_PASS} -e "grant all privileges on ${ZABBIX_DB_USER}.* to '${ZABBIX_DB_NAME}'@'${ZABBIX_DB_SERVER}'"
sudo mysql -h${ZABBIX_DB_SERVER} -u${ZABBIX_DB_USER} -p${ZABBIX_DB_PASS} -e "set global log_bin_trust_function_creators = 1"

sudo zcat /usr/share/zabbix-sql-scripts/mysql/server.sql.gz | mysql --default-character-set=utf8mb4 -h${ZABBIX_DB_SERVER} -D${ZABBIX_DB_NAME} -u${ZABBIX_DB_USER} -p${ZABBIX_DB_PASS}

##### Ajuste .conf #####
#sudo sed -i 's/DBUser=.*/DBUser=${ZABBIX_DB_USER}/' /etc/zabbix/zabbix_server.conf
#sudo sed -i 's/.*DBPassword=.*/DBPassword=${ZABBIX_DB_PASS}/' /etc/zabbix/zabbix_server.conf
#sudo sed -i 's/.*DBHost=.*/DBHost=${ZABBIX_DB_SERVER}/' /etc/zabbix/zabbix_server.conf
#sudo sed -i 's/.*DBName=.*/DBName=${ZABBIX_DB_NAME}/' /etc/zabbix/zabbix_server.conf
#sudo sed -i 's/.*php_value date.timezone Europe.*/php_value date.timezone America\/Sao_Paulo/' /etc/zabbix/apache.conf

##### Serviço #####
#sudo systemctl restart zabbix-server zabbix-agent apache2
#sudo systemctl enable zabbix-server zabbix-agent apache2
