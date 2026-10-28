variable "region" {
  default = "us-east-1"
}

variable "ami" {
  default = "ami-0d97d7f07b25dd693"
}

variable "worker_node_count" {
  default = "2"
}

variable "key_name" {
  default = "k8s-instances-key"
}

# variable "ports" {
#   type = list(string)
#   default = [ "22", "6443" , "80" ,"443" ]
# }