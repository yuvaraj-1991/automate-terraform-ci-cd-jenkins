resource "aws_s3_bucket" "yuvaraj-s3-latest-bucket" {
  bucket = "yuvaraj-s3-latest-bucket"
  force_destroy = true

  tags = {
    Name = "yuvaraj-s3-latest-bucket"
  }
}
