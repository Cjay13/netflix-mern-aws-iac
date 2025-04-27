
resource "aws_s3_bucket" "netflix-frontend-bucket" {
  bucket = "netflix-frontend-bucket"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = {
    Project = "netflix-clone-mern"
  }
}

resource "aws_s3_bucket" "netflix-frontend-logs-bucket" {
  bucket = "netflix-frontend-logs-bucket"

  tags = {
    Project = "netflix-clone-mern"
  }
}

resource "aws_s3_bucket_website_configuration" "netflix-frontend-bucket-webconfig" {
  bucket = aws_s3_bucket.netflix-frontend-bucket.id

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket_policy" "allow_cloudfront_access" {
  bucket = aws_s3_bucket.netflix-frontend-bucket.id
  policy = data.aws_iam_policy_document.allow_access_from_another_account.json
}

data "aws_iam_policy_document" "allow_cloudfront_access" {
  statement {
    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]

    resources = [
      "${aws_s3_bucket.netflix-frontend-bucket.arn}/*"
    ]

    Condition = {
        StringEquals = {
            "AWS:SourceArn" = aws_cloudfront_distribution.netflix_cloudfront_distribution.arn
        }
    }
  }
}