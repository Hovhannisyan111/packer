variable "subnet_ids" {
  type = list(string)
}

variable "security_group" {}

variable "instance_types" {
  default = "t2.micro"
}

variable "target_group_arn" {
  type = list(string)
}

variable "min_size" {
  default = 1
}

variable "max_size" {
  default = 2
}

variable "desired_capacity" {
  default = 1
}

variable "key_pair" {
  default = ""
}
