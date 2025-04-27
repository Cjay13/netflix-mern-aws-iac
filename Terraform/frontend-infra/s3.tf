
resource "aws_s3_bucket_website_configuration" "netflix-frontend-bucket" {
  bucket = netflix-frontend-bucket

  index_document {
    suffix = "index.html"
  }

}