#module "vpc" {
#  source              = "../modules/vpc"
#  cidr_block          = "10.0.0.0/16"
#  env                 = var.env
#  public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
#}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

module "sg" {
  source      = "../modules/sg"
  vpc_id      = data.aws_vpc.default.id
  allow_ports = [80, 22]
}

module "alb" {
  source             = "../modules/alb"
  subnet_ids         = data.aws_subnets.default.ids
  vpc_id             = data.aws_vpc.default.id
  security_group_ids = [module.sg.security_group_id]
}

module "sns" {
  source        = "../modules/sns"
  email_address = "ogannisyanarman4@gmail.com"
}

module "cloudwatch" {
  source        = "../modules/cloudWatch"
  sns_topic_arn = module.sns.sns_topic_arn
  asg_name      = module.asg.asg_name
}

module "asg" {
  source           = "../modules/asg"
  subnet_ids       = data.aws_subnets.default.ids
  security_group   = module.sg.security_group_id
  instance_types   = "t2.micro"
  key_pair         = "frankfurt"
  target_group_arn = module.alb.target_group_arn
  min_size         = 2
  max_size         = 4
  desired_capacity = 2
}
