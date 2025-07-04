#Data Pasta Orquestraor
data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "crfjunior-terraform-state-bia"
    key    = "vpc/terraform.tfstate"
    #key    = "RemoteState/vpc/terraform.tfstate"
    #bucket = "terraform-state-prod"
    #key    = "network/terraform.tfstate"
    region = "us-east-1"
  }
}
/*
data "terraform_remote_state" "orquestrador" {
  backend = "s3"
  config = {
    bucket = "crfjunior-terraform-state-zabbix"
    key    = "Orquestrador/terraform.tfstate"
    #key    = "RemoteState/vpc/terraform.tfstate"
    #bucket = "terraform-state-prod"
    #key    = "network/terraform.tfstate"
    region = "us-east-1"
  }
}

data "terraform_remote_state" "efs" {
  backend = "s3"
  config = {
    bucket = "crfjunior-terraform-state-zabbbix"
    key    = "efs/terraform.tfstate"
    #key    = "RemoteState/vpc/terraform.tfstate"
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
    #key    = "RemoteState/vpc/terraform.tfstate"
    #bucket = "terraform-state-prod"
    #key    = "network/terraform.tfstate"
    region = "us-east-1"
  }
}
*/
data "terraform_remote_state" "sg" {
  backend = "s3"
  config = {
    bucket = "crfjunior-terraform-state-bia"
    key    = "sg/terraform.tfstate"
    #key    = "RemoteState/vpc/terraform.tfstate"
    #bucket = "terraform-state-prod"
    #key    = "network/terraform.tfstate"
    region = "us-east-1"
  }
}


#data "aws_codestarconnections_connection" "github_app_connection" {
#  name = "crfjunior65" ####var.github_connection_name
#}

/*
data "terraform_remote_state" "ecs" {
  backend = "s3"
  config = {
    bucket = "crfjunior-remote-state"
    key    = "RemoteState/Projeto20/ECS/terraform.tfstate"
    #key    = "RemoteState/vpc/terraform.tfstate"
    #bucket = "terraform-state-prod"
    #key    = "network/terraform.tfstate"
    region = "us-east-1"
  }
}
*/


/*
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

  owners = ["amazon"]  # Dono das AMIs (Amazon)
}

data "aws_ami" "ubuntu_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]  # Dono das AMIs (Amazon)
}

data "aws_availability_zones" "available_zones" {
  state = "available"
}

data "aws_caller_identity" "current" {}

data "aws_ami_ids" "ubuntu-ami" {

  filter {
    name   = "name"
    values = ["ubuntu/images/ubuntu-*-*-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] # Canonical
}

data "aws_ami_ids" "amzn-linux-2023-ami" {
  #most_recent = true
  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}
*/