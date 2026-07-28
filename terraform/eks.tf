resource "aws_eks_cluster" "main" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks_cluster.arn
  version  = var.kubernetes_version

  vpc_config {
    subnet_ids = [
      aws_subnet.public_1.id,
      aws_subnet.public_2.id
    ]

    endpoint_private_access = false
    endpoint_public_access  = true
  }

  tags = merge(
    local.common_tags,
    {
      Name = var.cluster_name
    }
  )

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy
  ]
}

resource "aws_eks_node_group" "frontend" {
  cluster_name    = aws_eks_cluster.main.name
  version         = aws_eks_cluster.main.version
  node_group_name = "frontend-ng"
  node_role_arn   = aws_iam_role.worker_nodes.arn

  subnet_ids = [
    aws_subnet.public_1.id,
    aws_subnet.public_2.id
  ]

  instance_types = [var.frontend_instance_type]
  capacity_type  = "ON_DEMAND"
  disk_size      = 20

  scaling_config {
    desired_size = 1
    min_size     = 1
    max_size     = 2
  }

  labels = {
    workload = "frontend"
  }

  taint {
    key    = "workload"
    value  = "frontend"
    effect = "NO_SCHEDULE"
  }

  depends_on = [
    aws_iam_role_policy_attachment.worker_node,
    aws_iam_role_policy_attachment.worker_ecr,
    aws_iam_role_policy_attachment.worker_cni
  ]

  tags = merge(
    local.common_tags,
    {
      Name = "frontend-ng"
    }
  )
}

resource "aws_eks_node_group" "backend" {
  cluster_name    = aws_eks_cluster.main.name
  version         = aws_eks_cluster.main.version
  node_group_name = "backend-ng"
  node_role_arn   = aws_iam_role.worker_nodes.arn

  subnet_ids = [
    aws_subnet.public_1.id,
    aws_subnet.public_2.id
  ]

  instance_types = [var.backend_instance_type]
  capacity_type  = "ON_DEMAND"
  disk_size      = 20

  scaling_config {
    desired_size = 1
    min_size     = 1
    max_size     = 2
  }

  labels = {
    workload = "backend"
  }

  taint {
    key    = "workload"
    value  = "backend"
    effect = "NO_SCHEDULE"
  }

  depends_on = [
    aws_iam_role_policy_attachment.worker_node,
    aws_iam_role_policy_attachment.worker_ecr,
    aws_iam_role_policy_attachment.worker_cni
  ]

  tags = merge(
    local.common_tags,
    {
      Name = "backend-ng"
    }
  )
}
resource "aws_eks_node_group" "system" {
  cluster_name    = aws_eks_cluster.main.name
  version         = aws_eks_cluster.main.version
  node_group_name = "system-ng"
  node_role_arn   = aws_iam_role.worker_nodes.arn

  subnet_ids = [
    aws_subnet.public_1.id,
    aws_subnet.public_2.id
  ]

  instance_types = [var.system_instance_type]
  capacity_type  = "ON_DEMAND"
  disk_size      = 20

  scaling_config {
    desired_size = 1
    min_size     = 1
    max_size     = 2
  }

  labels = {
    workload = "system"
  }

  tags = merge(
    local.common_tags,
    {
      Name = "system-ng"
    }
  )

  depends_on = [
    aws_iam_role_policy_attachment.worker_node,
    aws_iam_role_policy_attachment.worker_ecr,
    aws_iam_role_policy_attachment.worker_cni
  ]
}