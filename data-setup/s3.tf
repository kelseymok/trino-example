resource "aws_s3_bucket" "data" {
  bucket = var.bucket-name
  acl    = "private"
}

resource "aws_s3_bucket_public_access_block" "data" {
  bucket = aws_s3_bucket.data.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_object" "data" {
  bucket = aws_s3_bucket.data.id
  key    = "data/data.parquet"
  source = "${path.module}/part-00000-a743c86c-acaa-4867-a7ab-5c6b4d20aacd-c000.snappy.parquet"
  etag = filemd5("${path.module}/part-00000-a743c86c-acaa-4867-a7ab-5c6b4d20aacd-c000.snappy.parquet")
}