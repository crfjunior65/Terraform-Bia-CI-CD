output "key_name_sa-1" {
  description = "Nome da chave SSH para acesso às instâncias."
  value       = aws_key_pair.deployer.key_name
}



#Bia DEV
#/*
output "EC2_bia_dev_sg_ids_sa-1" {
  description = "Ids dos SGs"
  value       = aws_instance.ec2_bastianhost.vpc_security_group_ids[*]
}

output "public_ip_sa-1" {
  value = aws_instance.ec2_bastianhost.public_ip[*]
}

output "private_ip_sa-1" {
  value = aws_instance.ec2_bastianhost.private_ip[*]
}


output "id_instancia_sa-1" {
  value = aws_instance.ec2_bastianhost.id[*]
}

#*/

#Bia Porteiro
/*
output "EC2_bia_dev_sg_ids" {
  description = "Ids dos SGs"
  value       = aws_instance.ec2_bia_porteiro.vpc_security_group_ids
}

output "public_ip" {
  value = aws_instance.ec2_bia_porteiro.public_ip
}

output "private_ip" {
  value = aws_instance.ec2_bia_porteiro.private_ip
}


output "id_instancia" {
  value = aws_instance.ec2_bia_porteiro.id
}

*/

