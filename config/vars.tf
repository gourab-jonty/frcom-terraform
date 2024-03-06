variable "instance_count" {}
variable "instance_type" {}
variable "ebs_optimized" {}
variable "ec2_size " {}
variable "name" {}
variable "port" {}
variable "protocol" {}
variable "instance_class" {}
variable "db_storage" {}
variable "engine" {}
variable "engine_version" {}
variable "region" {
  default = "ap-south-1"
  }
variable "vpc_name" {}
