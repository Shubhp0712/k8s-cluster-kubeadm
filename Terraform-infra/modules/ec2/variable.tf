variable "instance_type_master" {
  type        = string
  description = "Instance type for the master node"
}

variable "instance_type_worker" {
  type        = string
  description = "Instance type for the worker nodes"
}

variable "sg_id" {
  type        = string
  description = "Security group ID to associate with the instances"
}

variable "key_name" {
  type        = string
  description = "Name of the key pair to use for the instances"
}

variable "count_nodes" {
  type        = number
  description = "Number of worker nodes to create"
}

variable "master_tags" {
  type        = map(string)
  description = "Tags to apply to the master instances"
}

variable "worker_tags" {
  type        = map(string)
  description = "Tags to apply to the worker instances"
}

