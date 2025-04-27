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

  for_each = {
    for dvo in aws_acm_certificate.example.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
}