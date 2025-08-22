############################################
# Terraform & Provider Configuration
############################################

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.0"
    }
  }
}

provider "aws" {
  region = "ap-southeast-2"
}

locals {
  base_name        = "example"
  vpc_cidr         = "10.0.0.0/16"
  azs              = ["ap-southeast-2a", "ap-southeast-2b", "ap-southeast-2c"]
  public_subnets   = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnets  = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  database_subnets = ["10.0.7.0/24", "10.0.8.0/24", "10.0.9.0/24"]

  tags = {
    Name        = "example"
    Environment = "dev"
  }
}

module "vpc" {
  source = "cloudbuildlab/vpc/aws"

  vpc_name           = local.base_name
  vpc_cidr           = local.vpc_cidr
  availability_zones = local.azs

  public_subnet_cidrs   = local.public_subnets
  private_subnet_cidrs  = local.private_subnets
  database_subnet_cidrs = local.database_subnets

  # Enable Internet Gateway & NAT Gateway
  create_igw       = true
  nat_gateway_type = "single"

  tags = local.tags
}

# Basic example of using the ElastiCache Redis module
module "elasticache_redis" {
  source = "../../"

  # VPC Configuration
  vpc_id = module.vpc.vpc_id

  # Subnet Configuration - use actual VPC module outputs
  subnet_ids = module.vpc.private_subnet_ids

  # Cluster Configuration
  replication_group_id = "my-redis-cluster"
  node_type            = "cache.t3.micro"
  num_cache_clusters   = 2
  port                 = 6379
  engine_version       = "7.0"

  subnet_group_name    = "redis-example-subnet-group"
  parameter_group_name = "redis-example-param-group"
  security_group_name  = "redis-example-security-group"

  # Security Configuration
  security_group_ingress_rules = [
    {
      description = "Redis access from VPC"
      from_port   = 6379
      to_port     = 6379
      protocol    = "tcp"
      cidr_blocks = [module.vpc.vpc_cidr]
    }
  ]

  # Tags
  tags = local.tags
}
