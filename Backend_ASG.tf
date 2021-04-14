## ASG ##

data "aws_ami" "linux_ami" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-ecs-hvm-*-x86_64-ebs"]
  }
}


resource "aws_launch_configuration" "lc" {
  name_prefix     = "lc-${lower(local.app_name)}"
  image_id        = data.aws_ami.linux_ami.id
  instance_type   = local.instance_type
  key_name        = aws_key_pair.keypair.key_name
  security_groups = [aws_security_group.app_sg.id]
  #associate_public_ip_address = "true"
  user_data = data.template_file.user_data.rendered
  lifecycle { create_before_destroy = true }
  iam_instance_profile = aws_iam_instance_profile.profile.name
  ebs_block_device {
    device_name = "/dev/sdb"
    volume_type = "gp2"
    volume_size = 50
    encrypted   = true
  }
}

resource "aws_autoscaling_group" "asg" {
  name                  = "${lower(local.app_name)}-app-asg"
  vpc_zone_identifier   = [module.aws_core_infra.pri_sub1, module.aws_core_infra.pri_sub2]
  launch_configuration  = aws_launch_configuration.lc.name
  min_size              = 1
  max_size              = 2
  desired_capacity      = 1
  protect_from_scale_in = "true"
  target_group_arns     = [aws_lb_target_group.tgt_grp.arn]
  lifecycle { create_before_destroy = true }
  tags = concat(
    [
      {
        "key"                 = "Name"
        "value"               = "${local.app_name}-APP-SERVER"
        "propagate_at_launch" = true
      }
    ]
  )
}

resource "aws_autoscaling_policy" "ecs-autoscaling-policy" {
  name                   = "ASGAverageCPUUtilization"
  adjustment_type        = "ChangeInCapacity"
  policy_type            = "TargetTrackingScaling"
  autoscaling_group_name = aws_autoscaling_group.asg.name
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 70.0
  }
}

