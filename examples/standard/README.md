# Standard ElastiCache Redis Example

This example demonstrates a basic ElastiCache Redis setup with proper VPC infrastructure.

## What This Example Creates

### Infrastructure

- **VPC** with public, private, and database subnets across 3 availability zones
- **ElastiCache Redis cluster** in private subnets (2 nodes for high availability)
- **Security groups** for proper access control

### Redis Cluster

- **Type**: Multi-AZ Redis 7.0 replication group
- **Nodes**: 2 cache clusters (primary + replica)
- **Instance Type**: cache.t3.micro (cost-effective)
- **Port**: 6379 (standard Redis port)
- **Location**: Private subnets for security

## Prerequisites

1. **AWS CLI**: Ensure you have AWS CLI configured with appropriate permissions
2. **AWS Credentials**: Ensure you have AWS credentials configured

## Usage

### 1. Deploy the Infrastructure

```bash
terraform init
terraform plan
terraform apply
```

### 2. Access the Redis Cluster

The Redis cluster is deployed in private subnets for security. You can access it from:

- **Same VPC**: Any resource within the VPC can connect to Redis
- **VPN/Direct Connect**: If you have VPN or Direct Connect to the VPC
- **Bastion Host**: Create a bastion host in the public subnets to access Redis

### 3. Test Redis Connection

```bash
# From within the VPC (e.g., bastion host)
redis-cli -h <REDIS_ENDPOINT> -p 6379 ping
```

### 4. View Outputs

```bash
terraform output
```

## What This Demonstrates

### **Basic ElastiCache Setup:**

- ✅ **VPC Integration**: Basic VPC and subnet configuration
- ✅ **Security**: Redis in private subnets
- ✅ **High Availability**: Multi-AZ setup with 2 nodes
- ✅ **Resource Naming**: Basic naming for subnet groups, parameter groups, and security groups

## Outputs

- **VPC ID**: ID of the created VPC
- **Redis Endpoint**: Primary endpoint for Redis cluster
- **Redis Port**: Port number for Redis connections
- **Subnet IDs**: IDs of the private subnets where Redis is deployed

## Cleanup

```bash
terraform destroy
```
