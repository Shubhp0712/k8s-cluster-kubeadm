output "public_ip_control_node" {
  value = aws_instance.control_node.public_ip
}

output "public_ip_worker_node" {
  value = aws_instance.worker_node[*].public_ip
}