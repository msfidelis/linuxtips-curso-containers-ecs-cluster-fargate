resource "aws_ssm_parameter" "lb_arn" {
  name  = "/linuxtips/ecs/lb/id"
  value = aws_lb.main.arn
  type  = "String"
}

resource "aws_ssm_parameter" "lb_listener" {
  name  = "/linuxtips/ecs/lb/listerner"
  value = aws_lb_listener.main.arn
  type  = "String"
}

resource "aws_ssm_parameter" "lb_internal_arn" {
  name  = "/linuxtips/ecs/lb/internal/id"
  value = aws_lb.internal.arn
  type  = "String"
}

resource "aws_ssm_parameter" "lb_internal_listener" {
  name  = "/linuxtips/ecs/lb/internal/listerner"
  value = aws_lb_listener.internal.arn
  type  = "String"
}

resource "aws_ssm_parameter" "cloudmap" {
  name  = "/linuxtips/ecs/cloudmap/namespace"
  value = aws_service_discovery_private_dns_namespace.main.id
  type  = "String"
}