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