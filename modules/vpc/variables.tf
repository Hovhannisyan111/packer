variable "cidr_block" {
  default = "10.0.0.0/16"
}

variable "env" {
  default = "dev"
}

variable "public_subnet_cidrs" {
  type    = list(string)
  default = ["10.0.1.0/24"]
}
