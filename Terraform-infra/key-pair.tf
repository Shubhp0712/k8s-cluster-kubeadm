resource "tls_private_key" "key_pair" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "ssh_key" {
  key_name   = var.key_name
  public_key = tls_private_key.key_pair.public_key_openssh

  provisioner "local-exec" {
    command = "echo '${tls_private_key.key_pair.private_key_pem}' > ${var.key_name}.pem && chmod 400 ${var.key_name}.pem"
  }

  tags = {
    Name = "instance-key"
  }
}
