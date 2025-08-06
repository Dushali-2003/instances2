output "webserver_vm_public_ip" {
value = module.webserver.*.public_ip
}
output "loadbalancer_vm_public_ip" {
value = module.loadbalancer.*.public_ip
}
