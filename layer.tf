locals {
  chrome_aws_lambda_s3_key = "chrome_aws_lambda.zip"
}

# Uploading AWS lambda layer to S3 is faster
resource "aws_s3_bucket" "chrome_layer" {
  bucket_prefix = var.chrome_layer_bucket_prefix
  acl           = "private"
}

resource "aws_s3_bucket_public_access_block" "chrome_layer" {
  bucket = aws_s3_bucket.chrome_layer.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_object" "chrome_layer" {
  bucket = aws_s3_bucket.chrome_layer.id
  key    = local.chrome_aws_lambda_s3_key
  source = "chrome-aws-lambda/chrome_aws_lambda.zip"

  depends_on = [aws_s3_bucket_public_access_block.chrome_layer]
}

resource "aws_lambda_layer_version" "chrome_layer" {
  s3_bucket  = aws_s3_bucket.chrome_layer.id
  s3_key     = local.chrome_aws_lambda_s3_key
  layer_name = var.chrome_layer_name

  compatible_runtimes = ["nodejs10.x"]

  depends_on = [aws_s3_bucket_object.chrome_layer]
}
