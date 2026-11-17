# data "http" "public_ip" {
#   url = "https://ifconfig.me/ip"
# }

resource "aws_security_group" "sg1" {
  name = var.sg_name
  tags = var.sg_tag

  dynamic "ingress" {
    for_each = var.ports
    content {
      protocol = var.protocol
      from_port = ingress.value
      to_port   = ingress.value
      cidr_blocks = var.inbound_cidr_ipv4
      self = true
    }
  }
}

resource "aws_vpc_security_group_egress_rule" "allow_outbound" {
  security_group_id = aws_security_group.sg1.id
  cidr_ipv4         = var.outbound_cidr_ipv4
  ip_protocol       = var.outbound_protocol
}