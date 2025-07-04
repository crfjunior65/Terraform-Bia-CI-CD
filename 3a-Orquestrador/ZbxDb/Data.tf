#Data Pasta Orquestraor
# Dados IAMIs - aws ec2 describe-images --owners amazon |grep noble-24.04 |grep Name

data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"] # Dono das AMIs (Amazon)
}

#ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-arm64-server-20240605.1
data "aws_ami" "ubuntu_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Dono das AMIs (Amazon)
}

data "aws_ami" "ubuntu_linux_2204" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Dono das AMIs (Amazon)
}


data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "crfjunior-terraform-state-zabbix"
    key    = "vpc/terraform.tfstate"
    #key    = "RemoteState/vpc/terraform.tfstate"
    #bucket = "terraform-state-prod"
    #key    = "network/terraform.tfstate"
    region = "us-east-1"
  }
}

data "terraform_remote_state" "sg" {
  backend = "s3"
  config = {
    bucket = "crfjunior-terraform-state-zabbix"
    key    = "sg/terraform.tfstate"
    #key    = "RemoteState/EFS/terraform.tfstate"
    #bucket = "terraform-state-prod"
    #key    = "network/terraform.tfstate"
    region = "us-east-1"
  }
}

data "terraform_remote_state" "efs" {
  backend = "s3"
  config = {
    bucket = "crfjunior-terraform-state-zabbix"
    key    = "efs/terraform.tfstate"
    #key    = "RemoteState/EFS/terraform.tfstate"
    #bucket = "terraform-state-prod"
    #key    = "network/terraform.tfstate"
    region = "us-east-1"
  }
}

data "terraform_remote_state" "iam" {
  backend = "s3"
  config = {
    bucket = "crfjunior-terraform-state-zabbix"
    key    = "iam/terraform.tfstate"
    #key    = "RemoteState/EFS/terraform.tfstate"
    #bucket = "terraform-state-prod"
    #key    = "network/terraform.tfstate"
    region = "us-east-1"
  }
}

data "terraform_remote_state" "rds" {
  backend = "s3"
  config = {
    bucket = "crfjunior-terraform-state-zabbix"
    key    = "rds/terraform.tfstate"
    #key    = "RemoteState/EFS/terraform.tfstate"
    #bucket = "terraform-state-prod"
    #key    = "network/terraform.tfstate"
    region = "us-east-1"
  }
}

data "template_file" "install_zabbix_server" {
  template = file("install_zabbix_server.sh.tpl")

  vars = {
    ZABBIX_DB_USER   = "zabbix"                                                   #var.zabbix.services.db_user
    ZABBIX_DB_PASS   = "zabbix123456"                                             #var.zabbix.services.db_pass
    ZABBIX_DB_SERVER = "${data.terraform_remote_state.rds.outputs.db_db_address}" #aws_db_instance.banco_zabbix.address
    ZABBIX_DB_NAME   = "zabbix"
  }
}



/*

│   on Data.tf line 120, in data "template_file" "install_zabbix_server":
│  120:     ZABBIX_DB_SERVER = data.terraform_remote_state.rds.outputs.db_db_address #aws_db_instance.banco_zabbix.address
│     ├────────────────
│     │ data.terraform_remote_state.rds.outputs is object with no attributes
│
│ This object does not have an attribute named "db_db_address".
*/
