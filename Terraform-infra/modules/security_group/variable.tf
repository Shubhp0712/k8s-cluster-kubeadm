variable "sg_name" {
  type        = string
  description = "Name of the security group"
}

variable "sg_tag" {
  type        = map(string)
  description = "Tags for the security group"
}

variable "inbound_cidr_ipv4" {
  type        = string
  description = "CIDR block for the security group rules"
}

variable "outbound_cidr_ipv4" {
  type        = string
  description = "CIDR block for the outbound security group rules"
}

variable "ports" {
  type        = set(string)
  description = "Set of ports to allow in the security group"
}

variable "protocol" {
  type        = string
  description = "Protocol to use for the security group rules"
}

variable "outbound_protocol" {
  type        = string
  description = "Protocol to use for the outbound security group rules by Default it is -1 which means all protocols are allowed"
}