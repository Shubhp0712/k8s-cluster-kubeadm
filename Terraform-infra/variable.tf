variable "region" {
  type        = string
  description = "AWS region to deploy resources in"
}

variable "instance_type_master" {
  type        = string
  description = "Instance type for the master node"
}

variable "instance_type_worker" {
  type        = string
  description = "Instance type for the worker nodes"
}

variable "count_nodes" {
  type        = number
  description = "Number of worker nodes to create"
}

variable "master_tags" {
  type        = map(string)
  description = "Tags to apply to the master node"
}

variable "worker_tags" {
  type        = map(string)
  description = "Tags to apply to the worker nodes"
}


variable "sg_name" {
  type        = string
  description = "Name of the security group"
}

variable "inbound_cidr_ipv4" {
  type        = string
  description = "CIDR block for the inbound security group rules"
}
variable "outbound_cidr_ipv4" {
  type        = string
  description = "CIDR block for the outbound security group rules"
}

variable "protocol" {
  type        = string
  description = "Protocol for the Inbound security group rules"
}

variable "outbound_protocol" {
  type        = string
  description = "Protocol for the Outbound security group rules"
}

variable "ports" {
  type        = set(string)
  description = "List of ports to allow in the security group"
}

variable "sg_tag" {
  type        = map(string)
  description = "Tags to apply to the security group"
}

variable "key_name" {
  type        = string
  description = "Name of the key pair to use for the instances"
}

variable "key_pair_tag" {
  type        = string
  description = "Tags to apply to the key pair"
}

