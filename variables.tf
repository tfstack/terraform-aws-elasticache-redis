# General Configuration
variable "tags" {
  description = "A map of tags to assign to the resources"
  type        = map(string)
  default     = {}
}

# VPC Configuration
variable "vpc_id" {
  description = "The VPC ID where the ElastiCache cluster will be created"
  type        = string
}

# Subnet Group Configuration
variable "create_subnet_group" {
  description = "Whether to create a new subnet group"
  type        = bool
  default     = true
}

variable "subnet_group_name" {
  description = "Name of the subnet group"
  type        = string
  default     = null
}

variable "subnet_ids" {
  description = "List of VPC subnet IDs for the cache subnet group"
  type        = list(string)
  default     = []
}

# Parameter Group Configuration
variable "create_parameter_group" {
  description = "Whether to create a new parameter group"
  type        = bool
  default     = true
}

variable "parameter_group_name" {
  description = "Name of the parameter group"
  type        = string
  default     = null
}

variable "parameter_group_family" {
  description = "The family of the ElastiCache parameter group"
  type        = string
  default     = "redis7"
}

variable "parameter_group_parameters" {
  description = "List of parameters to apply to the parameter group"
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}

# Security Group Configuration
variable "create_security_group" {
  description = "Whether to create a new security group"
  type        = bool
  default     = true
}

variable "security_group_name" {
  description = "Name of the security group"
  type        = string
  default     = null
}

variable "security_group_ids" {
  description = "List of security group IDs to associate with the cluster"
  type        = list(string)
  default     = []
}

variable "security_group_names" {
  description = "List of security group names to associate with the cluster"
  type        = list(string)
  default     = []
}

variable "security_group_ingress_rules" {
  description = "List of security group ingress rules"
  type = list(object({
    description     = string
    from_port       = number
    to_port         = number
    protocol        = string
    cidr_blocks     = optional(list(string))
    security_groups = optional(list(string))
  }))
  default = [
    {
      description = "Redis port"
      from_port   = 6379
      to_port     = 6379
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

variable "security_group_egress_rules" {
  description = "List of security group egress rules"
  type = list(object({
    description     = string
    from_port       = number
    to_port         = number
    protocol        = string
    cidr_blocks     = optional(list(string))
    security_groups = optional(list(string))
  }))
  default = [
    {
      description = "All outbound traffic"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

# Cluster Configuration
variable "create_single_node" {
  description = "Whether to create a single node cluster"
  type        = bool
  default     = false
}

variable "create_replication_group" {
  description = "Whether to create a replication group"
  type        = bool
  default     = true
}

variable "cluster_id" {
  description = "The name of the ElastiCache cluster"
  type        = string
  default     = null
}

variable "replication_group_id" {
  description = "The name of the ElastiCache replication group"
  type        = string
  default     = null
}

variable "replication_group_description" {
  description = "The description of the ElastiCache replication group"
  type        = string
  default     = "Redis replication group"
}

variable "node_type" {
  description = "The compute and memory capacity of the nodes"
  type        = string
  default     = "cache.t3.micro"
}

variable "port" {
  description = "The port number on which each of the nodes accepts connections"
  type        = number
  default     = 6379
}

variable "engine_version" {
  description = "The version number of the cache engine"
  type        = string
  default     = "7.0"
}

variable "availability_zone" {
  description = "The Availability Zone for the cache cluster"
  type        = string
  default     = null
}

variable "availability_zones" {
  description = "A list of cache cluster availability zones"
  type        = list(string)
  default     = []
}

variable "num_cache_clusters" {
  description = "Number of cache clusters (primary and replicas) this replication group will have"
  type        = number
  default     = 2
}

variable "multi_az_enabled" {
  description = "Specifies whether to enable Multi-AZ Support for the replication group"
  type        = bool
  default     = false
}

variable "data_tiering_enabled" {
  description = "Enables data tiering. Data tiering is only supported for replication groups using the r6gd node type"
  type        = bool
  default     = false
}

variable "automatic_failover_enabled" {
  description = "Specifies whether a read-only replica will be automatically promoted to read/write primary if the existing primary fails"
  type        = bool
  default     = false
}

# Encryption Configuration
variable "at_rest_encryption_enabled" {
  description = "Whether to enable encryption at rest"
  type        = bool
  default     = false
}

variable "transit_encryption_enabled" {
  description = "Whether to enable encryption in transit"
  type        = bool
  default     = true
}

variable "kms_key_id" {
  description = "The ARN of the key that you wish to use if encrypting at rest"
  type        = string
  default     = null
}

variable "auth_token" {
  description = "The password used to access a password protected server"
  type        = string
  default     = null
  sensitive   = true
}

# Maintenance and Backup Configuration
variable "auto_minor_version_upgrade" {
  description = "Specifies whether a minor engine upgrade will be applied automatically to the underlying Cache Cluster instances"
  type        = bool
  default     = null
}

variable "maintenance_window" {
  description = "Specifies the weekly time range for when maintenance on the cache cluster is performed"
  type        = string
  default     = "wed:03:00-wed:04:00"
}

variable "snapshot_window" {
  description = "Daily time range during which ElastiCache will take a snapshot of the cache cluster"
  type        = string
  default     = "06:30-07:30"
}

variable "snapshot_retention_limit" {
  description = "Number of days for which ElastiCache will retain automatic cache cluster snapshots before deleting them"
  type        = number
  default     = 0
}

variable "final_snapshot_identifier" {
  description = "The name of your final cluster snapshot"
  type        = string
  default     = null
}

variable "apply_immediately" {
  description = "Specifies whether any modifications are applied immediately, or during the next maintenance window"
  type        = bool
  default     = true
}

# Notification Configuration
variable "notification_topic_arn" {
  description = "An Amazon Resource Name (ARN) of an SNS topic to send ElastiCache notifications to"
  type        = string
  default     = null
}

# Log Delivery Configuration
variable "log_delivery_configurations" {
  description = "List of log delivery configurations"
  type = list(object({
    destination      = string
    destination_type = string
    log_format       = string
    log_type         = string
  }))
  default = []
}
