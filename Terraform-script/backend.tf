terraform {
  backend "s3" {
    bucket = "capstone-state-bucket"
    key = "capstone-state-file"
    region = "eu-west-1"
    dynamodb_table = "capstone-state-lock"
    encrypt = true
  }
}

resource "aws_dynamodb_table" "terraform_state_lock" {
  name = "capstone-state-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}