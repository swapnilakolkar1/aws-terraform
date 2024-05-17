resource "aws_s3_bucket" "terraform-state" {
  bucket = "t3erraform-state-46"
  tags = {
    "Name" = "t3erraform-state-46"
  }
}
resource "aws_dynamodb_table" "key-lock-for-terraform-state" {
  name       = "terrafom-state-lock"
  depends_on = [aws_s3_bucket.terraform-state]
  attribute {
    name = "LockID"
    type = "S"
  }
  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"
  tags = {
    "Name" = "key-lock-for-terraform-state"
  }
  # billing_mode="PROVISIONED"
  # read_capacity  = 1
  # write_capacity = 1
}