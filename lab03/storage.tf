resource "random_id" "secret_postfix" {
  byte_length = 5
}

resource "aws_s3_bucket" "lab_storage" {
  bucket = "csdo1010-lab03-${random_id.secret_postfix.hex}"
}

output "s3_bucket" {
  value = aws_s3_bucket.lab_storage.bucket
}