resource "aws_security_group" "sg1" {
  name = var.sg_name
  tags = var.sg_tag
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.sg1.id
  for_each          = var.ports
  from_port         = each.value
  to_port           = each.value
  cidr_ipv4         = var.cidr_ipv4
  ip_protocol       = var.protocol
}

resource "aws_vpc_security_group_egress_rule" "allow_outbound" {
  security_group_id = aws_security_group.sg1.id
  cidr_ipv4         = var.cidr_ipv4
  ip_protocol       = var.outbound_protocol
}