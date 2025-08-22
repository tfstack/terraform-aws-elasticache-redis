# ElastiCache Subnet Group
resource "aws_elasticache_subnet_group" "this" {
  count      = var.create_subnet_group ? 1 : 0
  name       = var.subnet_group_name
  subnet_ids = var.subnet_ids

  tags = merge(
    var.tags,
    {
      Name = var.subnet_group_name
    }
  )
}

# ElastiCache Parameter Group
resource "aws_elasticache_parameter_group" "this" {
  count  = var.create_parameter_group ? 1 : 0
  family = var.parameter_group_family
  name   = var.parameter_group_name

  dynamic "parameter" {
    for_each = var.parameter_group_parameters
    content {
      name  = parameter.value.name
      value = parameter.value.value
    }
  }

  tags = merge(
    var.tags,
    {
      Name = var.parameter_group_name
    }
  )
}

# ElastiCache Security Group
resource "aws_security_group" "this" {
  count       = var.create_security_group ? 1 : 0
  name        = var.security_group_name
  description = "Security group for ElastiCache Redis cluster"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.security_group_ingress_rules
    content {
      description     = ingress.value.description
      from_port       = ingress.value.from_port
      to_port         = ingress.value.to_port
      protocol        = ingress.value.protocol
      cidr_blocks     = lookup(ingress.value, "cidr_blocks", null)
      security_groups = lookup(ingress.value, "security_groups", null)
    }
  }

  dynamic "egress" {
    for_each = var.security_group_egress_rules
    content {
      description     = egress.value.description
      from_port       = egress.value.from_port
      to_port         = egress.value.to_port
      protocol        = egress.value.protocol
      cidr_blocks     = lookup(egress.value, "cidr_blocks", null)
      security_groups = lookup(egress.value, "security_groups", null)
    }
  }

  tags = merge(
    var.tags,
    {
      Name = var.security_group_name
    }
  )
}

# ElastiCache Replication Group (Multi-AZ with Replication)
resource "aws_elasticache_replication_group" "this" {
  count = var.create_replication_group ? 1 : 0

  replication_group_id = var.replication_group_id
  description          = var.replication_group_description
  node_type            = var.node_type
  port                 = var.port
  parameter_group_name = var.create_parameter_group ? aws_elasticache_parameter_group.this[0].name : var.parameter_group_name
  subnet_group_name    = var.create_subnet_group ? aws_elasticache_subnet_group.this[0].name : var.subnet_group_name
  security_group_ids   = var.create_security_group ? [aws_security_group.this[0].id] : var.security_group_ids

  num_cache_clusters         = var.num_cache_clusters
  multi_az_enabled           = var.multi_az_enabled
  data_tiering_enabled       = var.data_tiering_enabled
  automatic_failover_enabled = var.automatic_failover_enabled
  at_rest_encryption_enabled = var.at_rest_encryption_enabled
  transit_encryption_enabled = var.transit_encryption_enabled
  kms_key_id                 = var.kms_key_id
  auth_token                 = var.auth_token
  engine                     = "redis"
  engine_version             = var.engine_version

  notification_topic_arn     = var.notification_topic_arn
  auto_minor_version_upgrade = var.auto_minor_version_upgrade
  maintenance_window         = var.maintenance_window
  snapshot_window            = var.snapshot_window
  snapshot_retention_limit   = var.snapshot_retention_limit
  final_snapshot_identifier  = var.final_snapshot_identifier
  apply_immediately          = var.apply_immediately

  dynamic "log_delivery_configuration" {
    for_each = var.log_delivery_configurations
    content {
      destination      = log_delivery_configuration.value.destination
      destination_type = log_delivery_configuration.value.destination_type
      log_format       = log_delivery_configuration.value.log_format
      log_type         = log_delivery_configuration.value.log_type
    }
  }

  tags = merge(
    var.tags,
    {
      Name = var.replication_group_id
    }
  )
}

# ElastiCache Cluster (Single Node)
resource "aws_elasticache_cluster" "this" {
  count = var.create_single_node ? 1 : 0

  cluster_id                 = var.cluster_id
  engine                     = "redis"
  node_type                  = var.node_type
  num_cache_nodes            = 1
  parameter_group_name       = var.create_parameter_group ? aws_elasticache_parameter_group.this[0].name : var.parameter_group_name
  port                       = var.port
  subnet_group_name          = var.create_subnet_group ? aws_elasticache_subnet_group.this[0].name : var.subnet_group_name
  security_group_ids         = var.create_security_group ? [aws_security_group.this[0].id] : var.security_group_ids
  availability_zone          = var.availability_zone
  engine_version             = var.engine_version
  notification_topic_arn     = var.notification_topic_arn
  auto_minor_version_upgrade = var.auto_minor_version_upgrade
  maintenance_window         = var.maintenance_window
  snapshot_window            = var.snapshot_window
  snapshot_retention_limit   = var.snapshot_retention_limit
  final_snapshot_identifier  = var.final_snapshot_identifier
  apply_immediately          = var.apply_immediately

  tags = merge(
    var.tags,
    {
      Name = var.cluster_id
    }
  )
}
