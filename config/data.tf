module "Data" {
  source       = "./module/data"
  vpc_tag_name = var.vpc_name
  region       = var.region
}
