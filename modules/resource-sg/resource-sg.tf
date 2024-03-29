resource "aws_security_group" "resource-sg" {
  vpc_id                 = var.vpc_id
  name                   = var.name
  description            = "security group that allows ssh and all egress traffic"
  revoke_rules_on_delete = false
  tags                   = local.default_tags

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port   = ingress.value["port"]
      to_port     = ingress.value["port"]
      protocol    = "tcp"
      cidr_blocks = ["10.0.0.0/8"]
    }
  }

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = var.vpc_cidr
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}




