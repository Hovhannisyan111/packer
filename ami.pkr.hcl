packer {
 required_plugins {
  amazon = {
    source = "github.com/hashicorp/amazon"
    version = ">= 1.0.0"
   }
   ansible = {
    version = ">= 1.0.0"
    source  = "github.com/hashicorp/ansible"
  }
 }
}

variable "ami_version" {
  default = "1"
}

source "amazon-ebs" "empty_ami" {
  region        = "eu-central-1"
  source_ami    = "ami-009082a6cd90ccd0e"
  instance_type = "t2.micro"
  ssh_username  = "ec2-user"
  ami_name      =  "packer-{{timestamp}}"
  tags = {
    Name        = format("Ansible-%s", var.ami_version)
  }
}

build {
 sources = [
   "source.amazon-ebs.empty_ami"
]

provisioner "ansible" {
  playbook_file = "playbook.yml"
 }
}

