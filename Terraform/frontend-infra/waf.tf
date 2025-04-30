resource aws_wafv2_web_acl" "netflix_cf_waf" {
  name        = "cloudfront_waf_acl"
  scope       = "CLOUDFRONT"
  
  default_action {
    allow {}
  }

  rule {
    name = "sql-injection-rule"
    priority = 1

    override_action = {
        none {}
    }

    statement {
        managed_rule_group_statement {
            name = "AWSManagedSQLiRule"
            vendor_name = "AWS"
        }
    }

    visibility_config {
        cloudwatch_metrics_enabled = true
        metric_name = "SQLIRule"
        sampled_requests_enabled = true
        
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name = "cloudfront_waf_acl"
    sampled_requests_enabled = true
  }
}

