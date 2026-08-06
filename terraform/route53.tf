data "aws_route53_zone" "main" {
  name         = "company.com"
  private_zone = false
}
#This health check continuously checks your application's health.
resource "aws_route53_health_check" "mumbai" {

  fqdn              = "app.company.com"

  port              = 443

  type              = "HTTPS"

  resource_path      = "/health"

  failure_threshold = 3

  request_interval  = 30

  tags = {
    Name = "Mumbai-HealthCheck"
  }
}
#Primary DNS Record
resource "aws_route53_record" "primary" {

  zone_id = data.aws_route53_zone.main.zone_id

  name = "app.company.com"

  type = "A"

  set_identifier = "Mumbai-Primary"

  failover_routing_policy {
    type = "PRIMARY"
  }

  health_check_id = aws_route53_health_check.mumbai.id

  alias {

    name = aws_lb.mumbai.dns_name

    zone_id = aws_lb.mumbai.zone_id

    evaluate_target_health = true
  }
}
#Secondary DNS Record (Hyderabad)
resource "aws_route53_record" "secondary" {

  zone_id = data.aws_route53_zone.main.zone_id

  name = "app.company.com"

  type = "A"

  set_identifier = "Hyderabad-Secondary"

  failover_routing_policy {
    type = "SECONDARY"
  }

  alias {

    name = aws_lb.hyderabad.dns_name

    zone_id = aws_lb.hyderabad.zone_id

    evaluate_target_health = true
  }
}
