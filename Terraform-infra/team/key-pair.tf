resource "tls_private_key" "key_pair" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "ssh_key" {
  key_name   = var.key_name
  public_key = tls_private_key.key_pair.public_key_openssh

  # provisioner "local-exec" {
  #   command = "echo '${tls_private_key.key_pair.private_key_pem}' > ${var.key_name}.pem && chmod 600 ${var.key_name}.pem && ssh-keygen -p -f ${var.key_name}.pem -N '${var.key_passphrase}' && chmod 400 ${var.key_name}.pem"
  # }
  provisioner "local-exec" {
    command = "echo '${tls_private_key.key_pair.private_key_pem}' > ${var.key_path}/${var.key_name}.pem && chmod 600 ${var.key_path}/${var.key_name}.pem && ssh-keygen -p -f ${var.key_path}/${var.key_name}.pem -N '${var.key_passphrase}' && chmod 400 ${var.key_path}/${var.key_name}.pem"
  }

  tags = {
    Name = var.key_pair_tag
  }
}

#ssh-keygen -p -f your-key.pem :-> To encrypt the .pem key file also while using ssh to ec2 we have to give passpharese that we set at the encryption.
