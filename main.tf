data "terraform_remote_state" "network_details" {
backend = "s3"
config = {
bucket = "student.50-garg-bucket"
key = "student.50-network-state"
region = "us-east-2"
}
}
