terraform {
  backend "s3" {
    bucket         = "petclinic-tfstate-bucket"
    key            = "test/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "pet-test-dynamodb-table"
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "pet-test-dynamodb-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}
