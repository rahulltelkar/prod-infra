##############################################################
# EKS Pod Identity Association
#
# Purpose:
# Creates a Pod Identity Association between a Kubernetes
# ServiceAccount and an AWS IAM Role.
#
# This file DOES NOT:
# - Create the IAM Role
# - Create the IAM Policy
# - Create the ServiceAccount
# - Install the EKS Pod Identity Agent
#
# It ONLY creates the mapping:
#
# EKS Cluster
#      ↓
# Namespace
#      ↓
# ServiceAccount
#      ↓
# IAM Role
#
# When a Pod uses this ServiceAccount, the EKS Pod Identity
# Agent retrieves temporary AWS credentials from STS using
# the associated IAM Role.
##############################################################

resource "aws_eks_pod_identity_association" "alb_controller" {
  cluster_name    = aws_eks_cluster.main.name
  namespace       = "kube-system"
  service_account = "aws-load-balancer-controller"
  role_arn        = aws_iam_role.alb_controller.arn
}