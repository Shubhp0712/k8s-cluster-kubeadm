output "public_ip_control_node" {
  value = module.ec2.public_ip_control_node
}

output "public_ip_worker_node" {
  value = module.ec2.public_ip_worker_node
}