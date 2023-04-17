variable "region" {
  description = "AWS region to create the resources in"
  type = string
  default = "eu-west-1"
}

variable "instance_count" {
  description = "Number of EC2 instances to create"
  type = number 
  default = 5
}