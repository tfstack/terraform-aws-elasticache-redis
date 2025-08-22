# Subnet Group Outputs
output "subnet_group_id" {
  description = "The ElastiCache subnet group ID"
  value       = var.create_subnet_group ? aws_elasticache_subnet_group.this[0].id : null
}

output "subnet_group_name" {
  description = "The ElastiCache subnet group name"
  value       = var.create_subnet_group ? aws_elasticache_subnet_group.this[0].name : var.subnet_group_name
}

# Parameter Group Outputs
output "parameter_group_id" {
  description = "The ElastiCache parameter group ID"
  value       = var.create_parameter_group ? aws_elasticache_parameter_group.this[0].id : null
}

output "parameter_group_name" {
  description = "The ElastiCache parameter group name"
  value       = var.create_parameter_group ? aws_elasticache_parameter_group.this[0].name : var.parameter_group_name
}

# Security Group Outputs
output "security_group_id" {
  description = "The ElastiCache security group ID"
  value       = var.create_security_group ? aws_security_group.this[0].id : null
}

output "security_group_name" {
  description = "The ElastiCache security group name"
  value       = var.create_security_group ? aws_security_group.this[0].name : var.security_group_name
}

output "security_group_arn" {
  description = "The ElastiCache security group ARN"
  value       = var.create_security_group ? aws_security_group.this[0].arn : null
}

# Replication Group Outputs
output "replication_group_id" {
  description = "The ID of the ElastiCache Replication Group"
  value       = var.create_replication_group ? aws_elasticache_replication_group.this[0].id : null
}

output "replication_group_arn" {
  description = "The ARN of the ElastiCache Replication Group"
  value       = var.create_replication_group ? aws_elasticache_replication_group.this[0].arn : null
}

output "replication_group_member_clusters" {
  description = "The identifiers of all the nodes that are part of this replication group"
  value       = var.create_replication_group ? aws_elasticache_replication_group.this[0].member_clusters : []
}

output "replication_group_primary_endpoint_address" {
  description = "The address of the endpoint for the primary node in the replication group"
  value       = var.create_replication_group ? aws_elasticache_replication_group.this[0].primary_endpoint_address : null
}

output "replication_group_reader_endpoint_address" {
  description = "The address of the endpoint for the reader node in the replication group"
  value       = var.create_replication_group ? aws_elasticache_replication_group.this[0].reader_endpoint_address : null
}

output "replication_group_configuration_endpoint_address" {
  description = "The address of the configuration endpoint for the replication group"
  value       = var.create_replication_group ? aws_elasticache_replication_group.this[0].configuration_endpoint_address : null
}

output "replication_group_port" {
  description = "The port number on which each of the nodes accepts connections"
  value       = var.create_replication_group ? aws_elasticache_replication_group.this[0].port : null
}

# Single Node Cluster Outputs
output "cluster_id" {
  description = "The ElastiCache cluster ID"
  value       = var.create_single_node ? aws_elasticache_cluster.this[0].id : null
}

output "cluster_arn" {
  description = "The ElastiCache cluster ARN"
  value       = var.create_single_node ? aws_elasticache_cluster.this[0].arn : null
}

output "cluster_endpoint_address" {
  description = "The DNS address of the cache node"
  value       = var.create_single_node ? aws_elasticache_cluster.this[0].cache_nodes[0].address : null
}

output "cluster_port" {
  description = "The port number on which each of the nodes accepts connections"
  value       = var.create_single_node ? aws_elasticache_cluster.this[0].port : null
}

# Common Outputs
output "redis_endpoint" {
  description = "The Redis endpoint address"
  value       = var.create_replication_group ? aws_elasticache_replication_group.this[0].primary_endpoint_address : (var.create_single_node ? aws_elasticache_cluster.this[0].cache_nodes[0].address : null)
}

output "redis_port" {
  description = "The Redis port number"
  value       = var.create_replication_group ? aws_elasticache_replication_group.this[0].port : (var.create_single_node ? aws_elasticache_cluster.this[0].port : null)
}

output "redis_url" {
  description = "The Redis connection URL"
  value       = var.create_replication_group ? "redis://${aws_elasticache_replication_group.this[0].primary_endpoint_address}:${aws_elasticache_replication_group.this[0].port}" : (var.create_single_node ? "redis://${aws_elasticache_cluster.this[0].cache_nodes[0].address}:${aws_elasticache_cluster.this[0].port}" : null)
}

output "node_type" {
  description = "The compute and memory capacity of the nodes"
  value       = var.node_type
}

output "engine_version" {
  description = "The version number of the cache engine"
  value       = var.engine_version
}

output "multi_az_enabled" {
  description = "Whether Multi-AZ is enabled"
  value       = var.create_replication_group ? aws_elasticache_replication_group.this[0].multi_az_enabled : null
}

output "automatic_failover_enabled" {
  description = "Whether automatic failover is enabled"
  value       = var.create_replication_group ? aws_elasticache_replication_group.this[0].automatic_failover_enabled : null
}

output "at_rest_encryption_enabled" {
  description = "Whether encryption at rest is enabled"
  value       = var.create_replication_group ? aws_elasticache_replication_group.this[0].at_rest_encryption_enabled : null
}

output "transit_encryption_enabled" {
  description = "Whether encryption in transit is enabled"
  value       = var.create_replication_group ? aws_elasticache_replication_group.this[0].transit_encryption_enabled : null
}
