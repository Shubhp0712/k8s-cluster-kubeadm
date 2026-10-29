terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = var.region
}

module "ec2" {
  source               = "./modules/ec2"
  instance_type_master = var.instance_type_master
  instance_type_worker = var.instance_type_worker
  sg_id                = module.security_group.sg-id
  key_name             = aws_key_pair.ssh_key.key_name
  count_nodes          = var.count_nodes
  master_tags          = var.master_tags
  worker_tags          = var.worker_tags
}

module "security_group" {
  source            = "./modules/security_group"
  sg_name           = var.sg_name
  cidr_ipv4         = var.cidr_ipv4
  protocol          = var.protocol
  outbound_protocol = var.outbound_protocol
  ports             = var.ports
  sg_tag            = var.sg_tag
}

resource "local_file" "name" {
  filename = var.file_path
  content  = <<EOT
  [control-node]
  control-plane ansible_host=${module.ec2.public_ip_control_node} 

  [worker-nodes]
  %{for i, ip in module.ec2.public_ip_worker_node~}
  worker-node-${i + 1} ansible_host=${ip}
  %{endfor~}

  [all:vars]
  ansible_user=ubuntu
  ansible_ssh_private_key_file=${var.key_path}/${var.key_name}.pem

  [cluster-nodes:children]
  control-node
  worker-nodes
  EOT
}