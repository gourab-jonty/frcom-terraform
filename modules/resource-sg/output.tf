output "instance-sg" {
  description = "SG for instance"
  value       = aws_security_group.FRCOM-EC2-SG.id
}
output "instance-sg-name" {
  description = "SG for instance"
  value       = aws_security_group.FRCOM-EC2-SG.name
}
