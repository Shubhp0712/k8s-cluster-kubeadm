data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["ubuntu-eks/k8s_1.26/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

resource "aws_instance" "control_node" {
  ami                    = data.aws_ami.ubuntu.id
  vpc_security_group_ids = [var.sg_id]
  key_name               = var.key_name
  instance_type          = var.instance_type_master

  tags = var.master_tags
}

resource "aws_instance" "worker_node" {
  ami                    = data.aws_ami.ubuntu.id
  count                  = var.count_nodes
  vpc_security_group_ids = [var.sg_id]
  key_name               = var.key_name
  instance_type          = var.instance_type_worker
  tags                   = var.worker_tags

  lifecycle {
    ignore_changes = [tags]
  }
}

