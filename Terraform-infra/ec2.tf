resource "aws_instance" "control_node" {
  ami           = var.ami
  instance_type = "t3.small"
  key_name      = aws_key_pair.ssh_key.key_name
  vpc_security_group_ids = [aws_security_group.sg1.id]
  depends_on    = [tls_private_key.key_pair]

  tags = {
    Name = "control_plane_node"
  }
}

resource "aws_instance" "worker_node" {
  ami           = var.ami
  count         = var.worker_node_count
  instance_type = "t3.micro"
  key_name      = aws_key_pair.ssh_key.key_name
  vpc_security_group_ids = [aws_security_group.sg1.id]
  depends_on    = [tls_private_key.key_pair]


  tags = {
    Name = "worker_node[${count.index + 1}]"
  }
}