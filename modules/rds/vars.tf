variable "instance_class" {}
variable "subnet_ids" {}
variable "vpc_id" {}
variable "engine" {}
variable "engine_version" {}
variable "name" {}
variable "maintenance_window" {
  type    = string
  default = "Sun:10:50-Thu:11:20"
}
variable "rds_sg" {}
variable "storage" {}