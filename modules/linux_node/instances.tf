resource "aws_instance" "my_vm" {
  count                  = var.instance_count
  ami                    = var.ami
  subnet_id              = var.subnet_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = var.vpc_security_group_ids
  tags                   = var.tags
}

resource "local_file" "tf_ansible_inventory" {
  count    = length(aws_instance.my_vm) > 0 ? 1 : 0

  content  = <<-EOT
[${var.install_package}]
%{for vm in aws_instance.my_vm[*]}
${vm.private_dns} ansible_host=${vm.public_ip} ansible_user=ubuntu ansible_ssh_private_key_file=/home/dushali/terraform_base2/keys2/student.50-vm-key ansible_ssh_common_args='-o IdentitiesOnly=yes'
%{endfor}
%{for vm in aws_instance.my_vm~}
${vm.private_dns} ansible_host=${vm.public_ip} ansible_ssh_user=ubuntu ansible_ssh_private_key_file='/home/dushali/terraform_base2/keys2/student.50-vm-key' ansible_ssh_common_args='-o IdentitiesOnly=yes'
%{endfor~}
EOT

  filename = "./tf_ansible_${var.install_package}_inventory.ini"
}


resource "time_sleep" "wait_30_seconds" {
  depends_on      = [aws_instance.my_vm]
  count           = length(aws_instance.my_vm) > 0 ? 1 : 0
  create_duration = "30s"
}

resource "null_resource" "install_package" {
  count      = length(aws_instance.my_vm) > 0 ? 1 : 0
  depends_on = [time_sleep.wait_30_seconds]
  provisioner "local-exec" {
  environment = {
      LC_ALL                  = "en_US.UTF-8"
      LANG                    = "en_US.UTF-8"
      ANSIBLE_SSH_COMMON_ARGS = " -o IdentitiesOnly=yes"
    }
    command = "sudo apt-get install openjdk-17-jdk -y && ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ubuntu -i ./tf_ansible_${var.install_package}_inventory.ini  ../ansible-playbooks/${var.playbook_name} --private-key '/home/dushali/terraform_base2/keys2/student.50-vm-key'"
 }
}
