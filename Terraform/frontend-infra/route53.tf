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