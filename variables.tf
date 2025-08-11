variable "region" {
default = "us-east-2"
}
variable "profile" {
default = "student.50"
}

variable "webserver_prefix" {
default = "student.50-webserver-vm"
}
variable "loadbalancer_prefix" {
default = "student.50-loadbalancer-vm"
}
variable "web_docker_host_prefix" {
default = "student.50-docker-vm"
}
variable "lb_docker_host_prefix" {
default = "student.50-lb_docker_host-vm"
}
 
