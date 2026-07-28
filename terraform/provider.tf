provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "platform-demo"
      ManagedBy   = "Terraform"
      Environment = var.environment
    }
  }
}