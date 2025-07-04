resource "aws_instance" "ec2_amz2023" {

  #depends_on = [aws_key_pair.deployer]

  #count = 2
  ami = data.terraform_remote_state.Orquestrador.outputs.ami_linux_amz_2023
  #data.aws_ami.amazon_linux_2023.id
  #"ami-0e449927258d45bc4"
  #data.aws_ami.amazon_linux_2023.id
  #data.terraform_remote_state.vpc.outputs.ami_amazon_linux.id
  instance_type = "t3.micro"

  # Configuração do volume raiz (EBS)
  root_block_device {
    volume_size = 8     # Tamanho em GiB (padrão: 8GB para muitas AMIs)
    volume_type = "gp3" # Tipo de volume (gp2, gp3, io1, etc.)
    #delete_on_termination = true
    #snapshot_id = null
  }

  #ebs_block_device {
  #  device_name = "/dev/sdh" # Se você realmente precisar de volumes adicionais
  #  volume_size = 30         # Pelo menos 30GB se usar o snapshot problemático
  #  volume_type = "gp3"
  #  snapshot_id = null # Explicitamente defina como null se não quiser usar snapshot
  #}

  key_name = data.terraform_remote_state.Orquestrador.outputs.key_name
  #key_name                    = data.terraform_remote_state.Orquestrador.outputs.key_name
  #var.key_name
  availability_zone           = data.terraform_remote_state.vpc.outputs.vpc_azs_id[0]
  subnet_id                   = data.terraform_remote_state.vpc.outputs.vpc_public_subnets_id[0]
  associate_public_ip_address = true

  #user_data            = file("InstallDev.sh")
  iam_instance_profile = data.terraform_remote_state.iam.outputs.iam_ssm_profile.id

  tags = {
    Name        = "Ec2-AmzLinux-2023" ######${count.index}"
    Terraform   = "true"
    AZ          = data.terraform_remote_state.vpc.outputs.vpc_azs_id[0]
    Environment = "Projeto"
    Management  = "Terraform"
    #Id_EFS      = data.terraform_remote_state.efs.outputs.efs_fs_id
  }

  vpc_security_group_ids = ["${data.terraform_remote_state.sg.outputs.sg_bia_dev}"]

}
