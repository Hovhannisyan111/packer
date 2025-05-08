data "aws_ami" "latest_packer" {
  most_recent = true
  owners      = ["self"]

  filter {
    name   = "name"
    values = ["packer-*"]
  }
}

resource "aws_launch_template" "web" {
  name_prefix   = "web-launch-"
  image_id      = data.aws_ami.latest_packer.id
  instance_type = var.instance_types
  key_name      = var.key_pair
  #user_data     = base64encode(file("${path.module}/userdata.sh"))

  vpc_security_group_ids = [var.security_group]

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "web-asg-instance"
    }
  }
}

resource "aws_autoscaling_group" "web_asg" {
  name                = "web-asg"
  vpc_zone_identifier = var.subnet_ids
  desired_capacity    = var.desired_capacity
  min_size            = var.min_size
  max_size            = var.max_size
  health_check_type   = "EC2"
  force_delete        = true
  launch_template {
    id      = aws_launch_template.web.id
    version = "$Latest"
  }
  target_group_arns = var.target_group_arn

  tag {
    key                 = "Name"
    value               = "Web"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}
