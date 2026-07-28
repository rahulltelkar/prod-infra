variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_1_cidr" {
  description = "CIDR block for public subnet 1"
  type        = string
}

variable "public_subnet_2_cidr" {
  description = "CIDR block for public subnet 2"
  type        = string
}

variable "cluster_name" {
  description = "EKS Cluster Name"
  type        = string
}

variable "system_instance_type" {
  description = "EC2 instance type for system node group"
  type        = string
  default     = "t3.small"
}

variable "frontend_instance_type" {
  description = "EC2 instance type for frontend node group"
  type        = string
  default     = "t3.small"
}

variable "backend_instance_type" {
  description = "EC2 instance type for backend node group"
  type        = string
  default     = "t3.small"
}

variable "kubernetes_version" {
  default = "1.33"
}