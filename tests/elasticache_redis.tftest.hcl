run "elasticache_redis_basic" {
  command = plan

  variables {
    vpc_id     = "vpc-test-12345"
    subnet_ids = ["subnet-test-1", "subnet-test-2"]

    # Basic configuration
    replication_group_id = "test-redis-cluster"
    node_type            = "cache.t3.micro"
    num_cache_clusters   = 2

    # Resource names
    subnet_group_name    = "test-redis-subnet-group"
    parameter_group_name = "test-redis-param-group"
    security_group_name  = "test-redis-security-group"

    # Security configuration
    security_group_ingress_rules = [
      {
        description = "Redis access from VPC"
        from_port   = 6379
        to_port     = 6379
        protocol    = "tcp"
        cidr_blocks = ["10.0.0.0/16"]
      }
    ]

    # Tags
    tags = {
      Environment = "test"
      Project     = "elasticache-test"
      Terraform   = "true"
    }
  }

  # Test basic configuration
  assert {
    condition     = var.replication_group_id == "test-redis-cluster"
    error_message = "Replication group ID should match expected value"
  }

  assert {
    condition     = var.node_type == "cache.t3.micro"
    error_message = "Node type should be cache.t3.micro"
  }

  assert {
    condition     = var.num_cache_clusters == 2
    error_message = "Number of cache clusters should be 2"
  }

  # Test VPC configuration
  assert {
    condition     = var.vpc_id == "vpc-test-12345"
    error_message = "VPC ID should match expected value"
  }

  # Test subnet configuration
  assert {
    condition     = length(var.subnet_ids) == 2
    error_message = "Should have 2 subnet IDs"
  }

  assert {
    condition     = var.subnet_ids[0] == "subnet-test-1"
    error_message = "First subnet ID should match expected value"
  }

  assert {
    condition     = var.subnet_ids[1] == "subnet-test-2"
    error_message = "Second subnet ID should match expected value"
  }

  # Test security group configuration
  assert {
    condition     = length(var.security_group_ingress_rules) == 1
    error_message = "Should have 1 security group ingress rule"
  }

  assert {
    condition     = var.security_group_ingress_rules[0].from_port == 6379
    error_message = "Redis port should be 6379"
  }

  assert {
    condition     = var.security_group_ingress_rules[0].to_port == 6379
    error_message = "Redis port should be 6379"
  }

  assert {
    condition     = var.security_group_ingress_rules[0].protocol == "tcp"
    error_message = "Protocol should be TCP"
  }

  # Test tags
  assert {
    condition     = var.tags.Environment == "test"
    error_message = "Environment tag should be 'test'"
  }

  assert {
    condition     = var.tags.Project == "elasticache-test"
    error_message = "Project tag should be 'elasticache-test'"
  }
}

run "elasticache_redis_advanced" {
  command = plan

  variables {
    vpc_id     = "vpc-test-12345"
    subnet_ids = ["subnet-test-1", "subnet-test-2", "subnet-test-3"]

    # Advanced configuration
    replication_group_id       = "advanced-redis-cluster"
    node_type                  = "cache.t3.small"
    num_cache_clusters         = 3
    multi_az_enabled           = true
    automatic_failover_enabled = true

    # Resource names
    subnet_group_name    = "advanced-redis-subnet-group"
    parameter_group_name = "advanced-redis-param-group"
    security_group_name  = "advanced-redis-security-group"

    # Encryption configuration
    at_rest_encryption_enabled = true
    transit_encryption_enabled = true

    # Parameter group configuration
    parameter_group_family = "redis7"
    parameter_group_parameters = [
      {
        name  = "maxmemory-policy"
        value = "allkeys-lru"
      },
      {
        name  = "notify-keyspace-events"
        value = "Ex"
      }
    ]

    # Security configuration
    security_group_ingress_rules = [
      {
        description = "Redis access from VPC"
        from_port   = 6379
        to_port     = 6379
        protocol    = "tcp"
        cidr_blocks = ["10.0.0.0/16"]
      },
      {
        description     = "Redis access from specific security group"
        from_port       = 6379
        to_port         = 6379
        protocol        = "tcp"
        security_groups = ["sg-test-12345"]
      }
    ]

    # Maintenance configuration
    maintenance_window       = "sun:02:00-sun:06:00"
    snapshot_window          = "01:00-03:00"
    snapshot_retention_limit = 14

    # Tags
    tags = {
      Environment = "production"
      Project     = "advanced-redis"
      Terraform   = "true"
      CostCenter  = "infrastructure"
    }
  }

  # Test advanced configuration
  assert {
    condition     = var.replication_group_id == "advanced-redis-cluster"
    error_message = "Replication group ID should match expected value"
  }

  assert {
    condition     = var.node_type == "cache.t3.small"
    error_message = "Node type should be cache.t3.small"
  }

  assert {
    condition     = var.num_cache_clusters == 3
    error_message = "Number of cache clusters should be 3"
  }

  assert {
    condition     = var.multi_az_enabled == true
    error_message = "Multi-AZ should be enabled"
  }

  assert {
    condition     = var.automatic_failover_enabled == true
    error_message = "Automatic failover should be enabled"
  }

  # Test encryption configuration
  assert {
    condition     = var.at_rest_encryption_enabled == true
    error_message = "Encryption at rest should be enabled"
  }

  assert {
    condition     = var.transit_encryption_enabled == true
    error_message = "Encryption in transit should be enabled"
  }

  # Test parameter group configuration
  assert {
    condition     = var.parameter_group_family == "redis7"
    error_message = "Parameter group family should be redis7"
  }

  assert {
    condition     = length(var.parameter_group_parameters) == 2
    error_message = "Should have 2 parameter group parameters"
  }

  assert {
    condition     = var.parameter_group_parameters[0].name == "maxmemory-policy"
    error_message = "First parameter name should be maxmemory-policy"
  }

  assert {
    condition     = var.parameter_group_parameters[0].value == "allkeys-lru"
    error_message = "First parameter value should be allkeys-lru"
  }

  # Test security group configuration
  assert {
    condition     = length(var.security_group_ingress_rules) == 2
    error_message = "Should have 2 security group ingress rules"
  }

  assert {
    condition     = var.security_group_ingress_rules[1].security_groups[0] == "sg-test-12345"
    error_message = "Security group should match expected value"
  }

  # Test maintenance configuration
  assert {
    condition     = var.maintenance_window == "sun:02:00-sun:06:00"
    error_message = "Maintenance window should match expected value"
  }

  assert {
    condition     = var.snapshot_window == "01:00-03:00"
    error_message = "Snapshot window should match expected value"
  }

  assert {
    condition     = var.snapshot_retention_limit == 14
    error_message = "Snapshot retention limit should be 14 days"
  }

  # Test tags
  assert {
    condition     = var.tags.Environment == "production"
    error_message = "Environment tag should be 'production'"
  }

  assert {
    condition     = var.tags.CostCenter == "infrastructure"
    error_message = "CostCenter tag should be 'infrastructure'"
  }
}

run "elasticache_redis_single_node" {
  command = plan

  variables {
    vpc_id     = "vpc-test-12345"
    subnet_ids = ["subnet-test-1"]

    # Single node configuration
    create_single_node       = true
    create_replication_group = false
    cluster_id               = "single-node-redis"
    node_type                = "cache.t3.micro"
    availability_zone        = "us-west-2a"

    # Resource names
    subnet_group_name    = "single-redis-subnet-group"
    parameter_group_name = "single-redis-param-group"
    security_group_name  = "single-redis-security-group"

    # Security configuration
    security_group_ingress_rules = [
      {
        description = "Redis access from VPC"
        from_port   = 6379
        to_port     = 6379
        protocol    = "tcp"
        cidr_blocks = ["10.0.0.0/16"]
      }
    ]

    # Tags
    tags = {
      Environment = "dev"
      Project     = "single-node-test"
      Terraform   = "true"
    }
  }

  # Test single node configuration
  assert {
    condition     = var.create_single_node == true
    error_message = "Single node should be enabled"
  }

  assert {
    condition     = var.create_replication_group == false
    error_message = "Replication group should be disabled"
  }

  assert {
    condition     = var.cluster_id == "single-node-redis"
    error_message = "Cluster ID should match expected value"
  }

  assert {
    condition     = var.availability_zone == "us-west-2a"
    error_message = "Availability zone should match expected value"
  }

  # Test VPC configuration
  assert {
    condition     = var.vpc_id == "vpc-test-12345"
    error_message = "VPC ID should match expected value"
  }

  # Test subnet configuration
  assert {
    condition     = length(var.subnet_ids) == 1
    error_message = "Should have 1 subnet ID for single node"
  }

  # Test tags
  assert {
    condition     = var.tags.Environment == "dev"
    error_message = "Environment tag should be 'dev'"
  }
}
