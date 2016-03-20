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
# Cluster machines
#
variable "ecs_amis" {
  default = {
    eu-west-1 = "ami-77ab1504"
  }
}
variable "instance_type" {
  default = "m3.medium"
  description = "The size machine to use for compute cluster machines."
}
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

variable "vpc_subnet_mask" {
  default = {
    eu-west-1 = "10.0.0.0/16"
  }
}
variable "subnet1_subnet_mask" {
  default = {
    eu-west-1 = "10.0.0.0/24"
  }
}
variable "subnet2_subnet_mask" {
  default = {
    eu-west-1 = "10.0.1.0/24"
  }
}
variable "availability_zones_1" {
  default = {
    eu-west-1 = "eu-west-1a"
  }
}
variable "availability_zones_2" {
  default = {
    eu-west-1 = "eu-west-1b"
  }
}

#
# Tasks/Services
#
variable "task_family" {
  default = "dev_"
  description = "The prefix to put on all task definitions created. e.g. dev_task-name"
}
