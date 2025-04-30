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

resource "null_resource" "wait_for_dns_propagation" {
  provisioner "local-exec" {
    command = "sleep 60"  # Sleep for 60 seconds to give time for DNS propagation
  }

  depends_on = [
    aws_route53_record.acm_validation,
    null_resource.wait_for_dns_propagation
  ]
}

resource "aws_acm_certificate_validation" "netflix-cert-validation" {
  provider = aws.useast1
  certificate_arn         = aws_acm_certificate.netflix-cert.arn
  validation_record_fqdns = [for record in aws_route53_record.acm_validation : record.fqdn]

  depends_on = [
    aws_route53_record.acm_validation
  ]
}

#test workflow 4