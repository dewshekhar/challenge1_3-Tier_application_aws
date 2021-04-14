#Load Balancer
resource "aws_lb" "lb" {
  name                       = "${local.app_name}-ALB"
  security_groups            = [aws_security_group.lb_sg.id]
  subnets                    = [module.aws_core_infra.pub_sub1, module.aws_core_infra.pub_sub2]
  enable_deletion_protection = false
  tags = {
    Name = "${local.app_name}-ALB"
  }
}

resource "aws_lb_target_group" "tgt_grp" {
  name     = "${local.app_name}-TGT-GRP"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.aws_core_infra.vpc_id
  health_check {
    path = "/"
  }
  target_type = "instance"
  tags = {
    Name = "${local.app_name}-TGT-GRP"
  }
}

resource "aws_lb_listener" "tg_listner" {
  load_balancer_arn = aws_lb.lb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    target_group_arn = aws_lb_target_group.tgt_grp.arn
    type             = "forward"
  }
}


/*
resource "aws_lb_target_group_attachment" "tg_att_ec2" {
  depends_on       = [aws_instance.media_ec2]
  target_group_arn = aws_lb_target_group.tgt_grp.arn
  target_id        = aws_instance.media_ec2.id
  port 	           = 80
}

*/