variable "vpc_id" {}

variable "ingress_rules" {
  type = list(object({
    port = number
  }))

  /*default = [
    {
      port = 22
    },
    {
      port = 443
    },
    {
      port = 80
    }
  ]*/
}
variable "vpc_cidr" {}