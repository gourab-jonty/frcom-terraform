######################
#  SECUIRITY GROUPS  #
######################
module "Resource-SG" {
  source        = "./modules/resource-sg"
  vpc_id        = module.Data.vpc_id
  ingress_rules = ["22", "443", "80"]
  vpc_cidr      = module.Data.vpc_cidr
}
module "ALB-SG" {
  source = "./modules/alb-sg"
  vpc_id = module.Data.vpc_id
}

###############
#  IAM ROLES  #
###############
module "EC2-Role" {
  source = "./modules/iam-role/ec2-role"
  name   = var.name
}

#########
#  EC2  #
#########
module "Linux-Server" {
  source           = "./modules/lin-server"
  instance_count   = var.instance_count
  linAMI           = module.Data.ami
  instance_type    = var.instance_type
  instance-profile = module.EC2-Role.instane-profile
  subnet_ids       = ["${module.Data.subnet-a}", "${module.Data.subnet-c}"]
  inst-sg          = ["${module.Resource-SG.instance-sg}"]
  vpc_id           = module.Data.vpc_id
  account_id       = module.Data.account_id
  vol_size         = var.ec2_size
  ebs_optimized    = var.ebs_optimized
}

#########
#  RDS  #
#########
module "RDS" {
  source         = "./modules/rds"
  instance_class = var.instance_class
  subnet_ids     = ["${module.Data.subnet-a}", "${module.Data.subnet-c}"]
  vpc_id         = module.Data.vpc_id
  name           = var.name
  rds_sg         = ["${module.Resource-SG.instance-sg}"]
  storage        = var.db_storage
  engine         = var.engine
  engine_version = var.engine_version

}

###################
#  TARGET GROUPS  #
###################
module "Target-Group" {
  source      = "./modules/target-group"
  name        = var.name
  port        = var.port
  vpc_id      = module.Data.vpc_id
  instance-id = module.Lin-Server.lin-id
}

###################
#  LOAD BALANCER  #
###################
module "Load-Balancer" {
  source    = "./modules/Load-Balancer"
  name      = var.name
  subnet_lb = ["${module.Data.subnet-a}", "${module.Data.subnet-c}"]
  inst-sg   = ["${module.ALB-SG.instance-sg}"]
}

##############
#  LISTENER  #
##############
module "Load-Balancer_Default_Listener" {
  source   = "./modules/Listener-Default"
  lb_arn   = module.Load-Balancer.arn
  tg_arn   = module.Target-Group.arn
  port     = var.port
  protocol = var.protocol
}

################
#  CLOUDFRONT  #
################
module "Research-Cloudfront" {
  source      = "./modules/cloudfront"
  domain_name = module.Load-Balancer.dns_name
  origin_id   = module.Load-Balancer.dns_name
  #target           = "${module.Load-Balancer.dns_name}"
  comment = "Demo-CDN"
}