terraform {
  backend "s3" {
    bucket         = "rahul-platform-tfstate-003107248036-dev"
    key            = "pre-aws-infra/terraform.tfstate"
    region         = "ap-south-1"
    encrypt        = true
    dynamodb_table = "rahul-terraform-state-lock"
  }
}