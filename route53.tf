resource "aws_route53_zone" "private" {
  name = format("%s.internal.com", var.project_name)

  vpc {
    vpc_id = data.aws_ssm_parameter.vpc.value
  }
}

resource "aws_route53_record" "wildcard" {
  zone_id = aws_route53_zone.private.zone_id
  name    = format("*.%s.internal.com", var.project_name)
  type    = "A"

  alias {
    name                   = aws_lb.internal.dns_name
    zone_id                = aws_lb.internal.zone_id
    evaluate_target_health = true
  }
}