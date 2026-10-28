resource "aws_security_group" "sg1" {
  name = "allow_ssh"

  tags = {
    Name = "sg-1" 
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
    security_group_id = aws_security_group.sg1.id
    cidr_ipv4 = "0.0.0.0/0"
    from_port = 22
    to_port = 22
    ip_protocol = "tcp"
}
resource "aws_vpc_security_group_ingress_rule" "allow_api-server" {
    security_group_id = aws_security_group.sg1.id
    cidr_ipv4 = "0.0.0.0/0"
    from_port = 6443
    to_port = 6443
    ip_protocol = "tcp"
}
resource "aws_vpc_security_group_ingress_rule" "allow_http" {
    security_group_id = aws_security_group.sg1.id
    cidr_ipv4 = "0.0.0.0/0"
    from_port = 80
    to_port = 80
    ip_protocol = "tcp"
}
resource "aws_vpc_security_group_ingress_rule" "allow_https" {
    security_group_id = aws_security_group.sg1.id
    cidr_ipv4 = "0.0.0.0/0"
    from_port = 443
    to_port = 443
    ip_protocol = "tcp"
}
resource "aws_vpc_security_group_egress_rule" "allow_outbound" {
    security_group_id = aws_security_group.sg1.id
    cidr_ipv4 = "0.0.0.0/0"
    ip_protocol = "-1"
}