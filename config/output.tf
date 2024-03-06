output "Data_Module" {
  value = module.Data
}
output "EC2-SG_Module" {
  value = module.FRCOM-EC2-SG
}
output "ALB-SG_Module" {
  value = module.FRCOM-ALB-SG
}
output "IAM-ROLE_Module" {
  value = module.EC2-Role
}
output "Common_Module" {
  value = module.common
}