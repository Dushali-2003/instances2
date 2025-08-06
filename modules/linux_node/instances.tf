resource "aws_instance" "my_vm" {
count = "2"
ami = var.ami
subnet_id = var.subnet_id
instance_type = var.instance_type
key_name = var.key_name
vpc_security_group_ids = var.vpc_security_group_ids
tags = var.tags 
}

