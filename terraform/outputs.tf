output "cluster_name" {
  value = aws_eks_cluster.main.name
}

output "cluster_endpoint" {
  value = aws_eks_cluster.main.endpoint
}

output "cluster_certificate_authority_data" {
  value     = aws_eks_cluster.main.certificate_authority[0].data
  sensitive = true
}

output "cluster_security_group_id" {
  value = aws_eks_cluster.main.vpc_config[0].cluster_security_group_id
}

output "frontend_node_group" {
  value = aws_eks_node_group.frontend.node_group_name
}

output "backend_node_group" {
  value = aws_eks_node_group.backend.node_group_name
}

output "system_node_group" {
  value = aws_eks_node_group.system.node_group_name
}