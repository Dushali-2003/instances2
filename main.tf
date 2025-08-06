data "terraform_remote_state" "network_details" {
backend = "s3"
config = {
bucket = "student.50-garg-bucket"
key = "student.50-network-state"
region = var.region
}
}
module "webserver" {
source = "./modules/linux_node"
ami = "ami-003932de22c285676"
instance_type = "t3.micro"
key_name = data.terraform_remote_state.network_details.outputs.my_key
subnet_id = data.terraform_remote_state.network_details.outputs.my_subnet
vpc_security_group_ids = data.terraform_remote_state.network_details.outputs.security_group_id_array
tags = {
Name = "student.50-vm1"
}
}
