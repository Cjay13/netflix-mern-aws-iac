resource "aws_acm_certificate" "cert" {
  domain_name       = "stream.cjaydevops.com"
  validation_method = "DNS"

  tags = {
    Project = "netflix-clone-mern"
  }

  lifecycle {
    create_before_destroy = true
  }
}