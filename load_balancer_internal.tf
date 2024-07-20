resource "aws_security_group" "lb_internal" {
  name   = format("%s-internal", var.project_name)
  vpc_id = data.aws_ssm_parameter.vpc.value

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
}

resource "aws_security_group_rule" "internal_ingress_80" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 80
  to_port           = 80
  description       = "Liberando trafego na porta 80"
  protocol          = "tcp"
  security_group_id = aws_security_group.lb_internal.id
  type              = "ingress"
}

resource "aws_security_group_rule" "internal_ingress_443" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 443
  to_port           = 443
  description       = "Liberando trafego na porta 443"
  protocol          = "tcp"
  security_group_id = aws_security_group.lb_internal.id
  type              = "ingress"
}

resource "aws_lb" "internal" {
  name     = format("%s-internal", var.project_name)
  internal = true

  load_balancer_type = "application"

  subnets = [
    data.aws_ssm_parameter.subnet_private_1a.value,
    data.aws_ssm_parameter.subnet_private_1b.value,
    data.aws_ssm_parameter.subnet_private_1c.value
  ]

  security_groups = [
    aws_security_group.lb_internal.id
  ]

  enable_cross_zone_load_balancing = false
  enable_deletion_protection       = false
}

resource "aws_lb_listener" "internal" {
  load_balancer_arn = aws_lb.internal.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "LinuxTips Internal"
      status_code  = "200"
    }
  }
}