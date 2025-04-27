resource "aws_acm_certificate" "netflix-cert" {
  provider = aws.useast1
  domain_name       = "stream.cjaydevops.com"
  validation_method = "DNS"

  tags = {
    Project = "netflix-clone-mern"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "netflix-cert-validation" {
  certificate_arn         = aws_acm_certificate.netflix-cert.arn
  validation_record_fqdns = [for record in aws_route53_record.acm_validation : record.fqdn]
}