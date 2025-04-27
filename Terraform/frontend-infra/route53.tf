resource "aws_route53_record" "netflix_cname" {
  zone_id = "Z0236041Q971BCTPRXPK"
  name    = "netflix"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.netflix_cloudfront_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.netflix_cloudfront_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "acm_validation" {
  zone_id = var.route53_zone_id
  name    = aws_acm_certificate.netflix-cert.domain_validation_options[0].resource_record_name
  type    = aws_acm_certificate.netflix-cert.domain_validation_options[0].resource_record_type
  ttl     = 60
  records = [aws_acm_certificate.netflix-cert.domain_validation_options[0].resource_record_value]
}