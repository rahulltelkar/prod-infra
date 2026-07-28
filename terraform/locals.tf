locals {
  common_tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
    Project     = "pre-demo-eks"
  }
}