data "terraform_remote_state" "network_details" {
backend = "s3"
config = {
bucket = "student.50-garg-bucket"
key = "student.50-network-state"
region = "us-east-2"
}
}
resource "aws_instance" "my_vm" {
ami = "ami-003932de22c285676"
subnet_id = data.terraform_remote_state.network_details.outputs.my_subnet
instance_type = "t3.micro"
tags = {
Name = "student.50-vm1"
}
}
