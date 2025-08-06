terraform {
backend "s3" {
bucket = "student.50-garg-bucket"
key = "student.50-instance-state"
region = "us-east-2"
}
}
