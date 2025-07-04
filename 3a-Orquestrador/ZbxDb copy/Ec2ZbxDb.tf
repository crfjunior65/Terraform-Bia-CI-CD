
resource "aws_instance" "ec2_zabbix_install" {

  #depends_on = [aws_key_pair.deployer]

  ami = data.aws_ami.ubuntu_linux_2204.id
  #data.terraform_remote_state.vpc.outputs.ami_amazon_linux.id
  instance_type = "t2.micro"

  key_name = var.key_name

  #Selecionar VPC
  #vpc_id      = module.vpc.vpc_id

  #Selecionar SubRede
  #subnet_id = module.vpc.vpc_id.public_subnets[0]
  subnet_id = data.terraform_remote_state.vpc.outputs.vpc_public_subnets_id[0]
  # module.vpc.public_subnets[0]

  #Atribuir IP Publico
  associate_public_ip_address = true

  #iam_instance_profile        = data.terraform_remote_state.vpc.outputs.iam_ssm_profile
  #aws_iam_instance_profile.ecs_node.id

  #Definir Volume

  user_data = data.template_file.install_zabbix_server.rendered

  #user_data = file("Installzbbix_server.sh.tpl")

  #user_data = << EOF
  #              #! /bin/bash
  #              cd /home/ubuntu
  #              apt update -y
  #              apt upgrade -y
  #              apt install wget unzip -y
  #              TER_VER=$(curl -s https://api.github.com/repos/hashicorp/terraform/releases/latest | grep tag_name | cut -d: -f2 | tr -d \"\,\v | awk '{$1=$1};1')
  #              wget https://releases.hashicorp.com/terraform/${TER_VER}/terraform_${TER_VER}_linux_amd64.zip
  #              unzip terraform_${TER_VER}_linux_amd64.zip
  #              mv terraform /usr/local/bin/
  #              EOF

  # Associar o Role SSM à instância EC2
  iam_instance_profile = data.terraform_remote_state.iam.outputs.iam_s3_profile.id
  #data.terraform_remote_state.iam.outputs.iam_ssm_profile.id
  #aws_iam_instance_profile.ssm_profile.name

  ###
  /*
provisioner "remote-exec" {
    inline = [
      # Mounting Efs
      #"sudo mount -t nfs -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport ${aws_efs_file_system.efs.dns_name}:/  /var/www/html",
      "sudo mount -t nfs -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport ${data.terraform_remote_state.EFS.efs_fs_dns}:/  /home/ec2-user/GLPI",
      "sleep 15",
      "sudo chmod go+rw /home/ec2-user/GLPI",
      "sudo bash -c 'echo Welcome  > /home/ec2-user/GLPI/index.html'",
    ]
  }
*/
  ###

  tags = {
    Name        = "Zabbix_InstallDB"
    Terraform   = "true"
    Environment = "Projeto"
    Management  = "Terraform"
    Id_EFS      = data.terraform_remote_state.efs.outputs.efs_fs_id
  }
  vpc_security_group_ids = ["${data.terraform_remote_state.sg.outputs.sg_ssh_id}",
    "${data.terraform_remote_state.sg.outputs.sg_http_id}",
    "${data.terraform_remote_state.sg.outputs.sg_rds_id}",
  "${data.terraform_remote_state.sg.outputs.sg_efs_id}"]
  #vpc_security_group_ids = ["${aws_security_group.acesso-ssh.id}",
  #"${aws_security_group.acesso-http.id}", "${aws_security_group.acesso-rds.id}"]

  provisioner "remote-exec" {
    #depends_on =
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("aws-key-terraform")
      host        = self.public_ip
      timeout     = "35s"
    }

    inline = [
      # Instalar o cliente NFS
      #"sudo apt update -y",
      #"sudo apt upgrade -y",

      # Criar diretório para montagem
      "sudo mkdir -p /mnt/efs",
      "sleep 120",

      # Montar o EFS
      "sudo mount -t efs ${data.terraform_remote_state.efs.outputs.efs_fs_id}:/ /home/ubuntu/Data",
      "sudo chmod go+rw /home/uuntu/Data",
      "sudo bash -c 'echo Welcome  > /home/ubuntu/Data/index.html'",
      "sudo chown -R ubuntu:ubuntu /home/ubuntu/",

      # Persistir a montagem (opcional)
      "sudo bash -c echo '${data.terraform_remote_state.efs.outputs.efs_fs_id}:/ /home/ubuntu/Data efs defaults,_netdev 0 0' | sudo tee -a /etc/fstab"
    ]
  }

}
