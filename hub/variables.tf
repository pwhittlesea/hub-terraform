#
# Variables file
#

variable "aws_region" {
  default = "eu-west-1"
  description = "The AWS region to deploy this application in."
}
variable "aws_profile" {
  default = "default"
  description = "The AWS CLI profile to use for authentication with AWS."
}
variable "stack_name" {
  description = "Global Stack name - will prefix all created objects"
}

#
# VPC information
#
variable "vpc_id" {
  description = "The VPC to place Security Groups in."
}
variable "subnet_id_1" {
  description = "The first subnet to distribute machines in."
}
variable "route_53_zone_id" {
  description = "The Route 53 Zone to create entries in."
}

#
# Zookeeper machines
#
variable "zk_cluster_size" {
  default = "3"
  description = "The number of Zookeeper nodes to deploy/manage."
}
variable "zk_amis" {
  default = {
    eu-west-1 = "ami-a0a218d3"
  }
}
variable "zk_instance_type" {
  default = "t2.micro"
  description = "The size machine to use for Zookeeper cluster machines."
}

#
# Security
#
variable "ssh_key_name" {
  description = "The name of the SSH key to use to access compute cluster machines."
}

#
# Networking
#
variable "internal_dns_tld" {
  default = "thehub.internal"
  description = "TLD of Route 53 entries"
}
