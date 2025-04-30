resource "aws_cloudfront_origin_access_control" "netflix-frontend-oac" {
  name                              = "netflix-frontend-oac"
  description                       = "OAC for CloudFront accessing S3 bucket"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

locals {
  s3_origin_id = "netflix-frontend-origin"
}


resource "aws_cloudfront_distribution" "netflix_cloudfront_distribution" {
  origin {
    domain_name              = aws_s3_bucket.netflix-frontend-bucket.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.netflix-frontend-oac.id
    origin_id                = local.s3_origin_id
  }

  enabled             = true

  default_root_object = "index.html"

#  logging_config {
#    include_cookies = false
#    bucket          = aws_s3_bucket.netflix-frontend-logs-bucket.bucket_domain_name
#    prefix          = "netflix-frontend"
#  }

  aliases = ["stream.cjaydevops.com"]

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
  }

  restrictions {
    geo_restriction {
        restriction_type = "none" 
        locations = [] 
    }
  }

  web_acl_id = aws_wafv2_web_acl.netflix_cf_waf.arn

  tags = {
    Project = "netflix-clone-mern"
  }

  viewer_certificate {
    acm_certificate_arn = aws_acm_certificate.netflix-cert.arn
    ssl_support_method = "sni-only"
  }

  depends_on = [
    aws_acm_certificate_validation.netflix-cert-validation
  ]
}
