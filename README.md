# terraform-aws-elasticache-redis

Terraform module to provision and manage an AWS ElastiCache Redis cluster

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.10.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_elasticache_cluster.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_cluster) | resource |
| [aws_elasticache_parameter_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_parameter_group) | resource |
| [aws_elasticache_replication_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_replication_group) | resource |
| [aws_elasticache_subnet_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_subnet_group) | resource |
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apply_immediately"></a> [apply\_immediately](#input\_apply\_immediately) | Specifies whether any modifications are applied immediately, or during the next maintenance window | `bool` | `true` | no |
| <a name="input_at_rest_encryption_enabled"></a> [at\_rest\_encryption\_enabled](#input\_at\_rest\_encryption\_enabled) | Whether to enable encryption at rest | `bool` | `false` | no |
| <a name="input_auth_token"></a> [auth\_token](#input\_auth\_token) | The password used to access a password protected server | `string` | `null` | no |
| <a name="input_auto_minor_version_upgrade"></a> [auto\_minor\_version\_upgrade](#input\_auto\_minor\_version\_upgrade) | Specifies whether a minor engine upgrade will be applied automatically to the underlying Cache Cluster instances | `bool` | `null` | no |
| <a name="input_automatic_failover_enabled"></a> [automatic\_failover\_enabled](#input\_automatic\_failover\_enabled) | Specifies whether a read-only replica will be automatically promoted to read/write primary if the existing primary fails | `bool` | `false` | no |
| <a name="input_availability_zone"></a> [availability\_zone](#input\_availability\_zone) | The Availability Zone for the cache cluster | `string` | `null` | no |
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | A list of cache cluster availability zones | `list(string)` | `[]` | no |
| <a name="input_cluster_id"></a> [cluster\_id](#input\_cluster\_id) | The name of the ElastiCache cluster | `string` | `null` | no |
| <a name="input_create_parameter_group"></a> [create\_parameter\_group](#input\_create\_parameter\_group) | Whether to create a new parameter group | `bool` | `true` | no |
| <a name="input_create_replication_group"></a> [create\_replication\_group](#input\_create\_replication\_group) | Whether to create a replication group | `bool` | `true` | no |
| <a name="input_create_security_group"></a> [create\_security\_group](#input\_create\_security\_group) | Whether to create a new security group | `bool` | `true` | no |
| <a name="input_create_single_node"></a> [create\_single\_node](#input\_create\_single\_node) | Whether to create a single node cluster | `bool` | `false` | no |
| <a name="input_create_subnet_group"></a> [create\_subnet\_group](#input\_create\_subnet\_group) | Whether to create a new subnet group | `bool` | `true` | no |
| <a name="input_data_tiering_enabled"></a> [data\_tiering\_enabled](#input\_data\_tiering\_enabled) | Enables data tiering. Data tiering is only supported for replication groups using the r6gd node type | `bool` | `false` | no |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | The version number of the cache engine | `string` | `"7.0"` | no |
| <a name="input_final_snapshot_identifier"></a> [final\_snapshot\_identifier](#input\_final\_snapshot\_identifier) | The name of your final cluster snapshot | `string` | `null` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | The ARN of the key that you wish to use if encrypting at rest | `string` | `null` | no |
| <a name="input_log_delivery_configurations"></a> [log\_delivery\_configurations](#input\_log\_delivery\_configurations) | List of log delivery configurations | <pre>list(object({<br/>    destination      = string<br/>    destination_type = string<br/>    log_format       = string<br/>    log_type         = string<br/>  }))</pre> | `[]` | no |
| <a name="input_maintenance_window"></a> [maintenance\_window](#input\_maintenance\_window) | Specifies the weekly time range for when maintenance on the cache cluster is performed | `string` | `"wed:03:00-wed:04:00"` | no |
| <a name="input_multi_az_enabled"></a> [multi\_az\_enabled](#input\_multi\_az\_enabled) | Specifies whether to enable Multi-AZ Support for the replication group | `bool` | `false` | no |
| <a name="input_node_type"></a> [node\_type](#input\_node\_type) | The compute and memory capacity of the nodes | `string` | `"cache.t3.micro"` | no |
| <a name="input_notification_topic_arn"></a> [notification\_topic\_arn](#input\_notification\_topic\_arn) | An Amazon Resource Name (ARN) of an SNS topic to send ElastiCache notifications to | `string` | `null` | no |
| <a name="input_num_cache_clusters"></a> [num\_cache\_clusters](#input\_num\_cache\_clusters) | Number of cache clusters (primary and replicas) this replication group will have | `number` | `2` | no |
| <a name="input_parameter_group_family"></a> [parameter\_group\_family](#input\_parameter\_group\_family) | The family of the ElastiCache parameter group | `string` | `"redis7"` | no |
| <a name="input_parameter_group_name"></a> [parameter\_group\_name](#input\_parameter\_group\_name) | Name of the parameter group | `string` | `null` | no |
| <a name="input_parameter_group_parameters"></a> [parameter\_group\_parameters](#input\_parameter\_group\_parameters) | List of parameters to apply to the parameter group | <pre>list(object({<br/>    name  = string<br/>    value = string<br/>  }))</pre> | `[]` | no |
| <a name="input_port"></a> [port](#input\_port) | The port number on which each of the nodes accepts connections | `number` | `6379` | no |
| <a name="input_replication_group_description"></a> [replication\_group\_description](#input\_replication\_group\_description) | The description of the ElastiCache replication group | `string` | `"Redis replication group"` | no |
| <a name="input_replication_group_id"></a> [replication\_group\_id](#input\_replication\_group\_id) | The name of the ElastiCache replication group | `string` | `null` | no |
| <a name="input_security_group_egress_rules"></a> [security\_group\_egress\_rules](#input\_security\_group\_egress\_rules) | List of security group egress rules | <pre>list(object({<br/>    description     = string<br/>    from_port       = number<br/>    to_port         = number<br/>    protocol        = string<br/>    cidr_blocks     = optional(list(string))<br/>    security_groups = optional(list(string))<br/>  }))</pre> | <pre>[<br/>  {<br/>    "cidr_blocks": [<br/>      "0.0.0.0/0"<br/>    ],<br/>    "description": "All outbound traffic",<br/>    "from_port": 0,<br/>    "protocol": "-1",<br/>    "to_port": 0<br/>  }<br/>]</pre> | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | List of security group IDs to associate with the cluster | `list(string)` | `[]` | no |
| <a name="input_security_group_ingress_rules"></a> [security\_group\_ingress\_rules](#input\_security\_group\_ingress\_rules) | List of security group ingress rules | <pre>list(object({<br/>    description     = string<br/>    from_port       = number<br/>    to_port         = number<br/>    protocol        = string<br/>    cidr_blocks     = optional(list(string))<br/>    security_groups = optional(list(string))<br/>  }))</pre> | <pre>[<br/>  {<br/>    "cidr_blocks": [<br/>      "0.0.0.0/0"<br/>    ],<br/>    "description": "Redis port",<br/>    "from_port": 6379,<br/>    "protocol": "tcp",<br/>    "to_port": 6379<br/>  }<br/>]</pre> | no |
| <a name="input_security_group_name"></a> [security\_group\_name](#input\_security\_group\_name) | Name of the security group | `string` | `null` | no |
| <a name="input_security_group_names"></a> [security\_group\_names](#input\_security\_group\_names) | List of security group names to associate with the cluster | `list(string)` | `[]` | no |
| <a name="input_snapshot_retention_limit"></a> [snapshot\_retention\_limit](#input\_snapshot\_retention\_limit) | Number of days for which ElastiCache will retain automatic cache cluster snapshots before deleting them | `number` | `0` | no |
| <a name="input_snapshot_window"></a> [snapshot\_window](#input\_snapshot\_window) | Daily time range during which ElastiCache will take a snapshot of the cache cluster | `string` | `"06:30-07:30"` | no |
| <a name="input_subnet_group_name"></a> [subnet\_group\_name](#input\_subnet\_group\_name) | Name of the subnet group | `string` | `null` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | List of VPC subnet IDs for the cache subnet group | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the resources | `map(string)` | `{}` | no |
| <a name="input_transit_encryption_enabled"></a> [transit\_encryption\_enabled](#input\_transit\_encryption\_enabled) | Whether to enable encryption in transit | `bool` | `true` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The VPC ID where the ElastiCache cluster will be created | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_at_rest_encryption_enabled"></a> [at\_rest\_encryption\_enabled](#output\_at\_rest\_encryption\_enabled) | Whether encryption at rest is enabled |
| <a name="output_automatic_failover_enabled"></a> [automatic\_failover\_enabled](#output\_automatic\_failover\_enabled) | Whether automatic failover is enabled |
| <a name="output_cluster_arn"></a> [cluster\_arn](#output\_cluster\_arn) | The ElastiCache cluster ARN |
| <a name="output_cluster_endpoint_address"></a> [cluster\_endpoint\_address](#output\_cluster\_endpoint\_address) | The DNS address of the cache node |
| <a name="output_cluster_id"></a> [cluster\_id](#output\_cluster\_id) | The ElastiCache cluster ID |
| <a name="output_cluster_port"></a> [cluster\_port](#output\_cluster\_port) | The port number on which each of the nodes accepts connections |
| <a name="output_engine_version"></a> [engine\_version](#output\_engine\_version) | The version number of the cache engine |
| <a name="output_multi_az_enabled"></a> [multi\_az\_enabled](#output\_multi\_az\_enabled) | Whether Multi-AZ is enabled |
| <a name="output_node_type"></a> [node\_type](#output\_node\_type) | The compute and memory capacity of the nodes |
| <a name="output_parameter_group_id"></a> [parameter\_group\_id](#output\_parameter\_group\_id) | The ElastiCache parameter group ID |
| <a name="output_parameter_group_name"></a> [parameter\_group\_name](#output\_parameter\_group\_name) | The ElastiCache parameter group name |
| <a name="output_redis_endpoint"></a> [redis\_endpoint](#output\_redis\_endpoint) | The Redis endpoint address |
| <a name="output_redis_port"></a> [redis\_port](#output\_redis\_port) | The Redis port number |
| <a name="output_redis_url"></a> [redis\_url](#output\_redis\_url) | The Redis connection URL |
| <a name="output_replication_group_arn"></a> [replication\_group\_arn](#output\_replication\_group\_arn) | The ARN of the ElastiCache Replication Group |
| <a name="output_replication_group_configuration_endpoint_address"></a> [replication\_group\_configuration\_endpoint\_address](#output\_replication\_group\_configuration\_endpoint\_address) | The address of the configuration endpoint for the replication group |
| <a name="output_replication_group_id"></a> [replication\_group\_id](#output\_replication\_group\_id) | The ID of the ElastiCache Replication Group |
| <a name="output_replication_group_member_clusters"></a> [replication\_group\_member\_clusters](#output\_replication\_group\_member\_clusters) | The identifiers of all the nodes that are part of this replication group |
| <a name="output_replication_group_port"></a> [replication\_group\_port](#output\_replication\_group\_port) | The port number on which each of the nodes accepts connections |
| <a name="output_replication_group_primary_endpoint_address"></a> [replication\_group\_primary\_endpoint\_address](#output\_replication\_group\_primary\_endpoint\_address) | The address of the endpoint for the primary node in the replication group |
| <a name="output_replication_group_reader_endpoint_address"></a> [replication\_group\_reader\_endpoint\_address](#output\_replication\_group\_reader\_endpoint\_address) | The address of the endpoint for the reader node in the replication group |
| <a name="output_security_group_arn"></a> [security\_group\_arn](#output\_security\_group\_arn) | The ElastiCache security group ARN |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | The ElastiCache security group ID |
| <a name="output_security_group_name"></a> [security\_group\_name](#output\_security\_group\_name) | The ElastiCache security group name |
| <a name="output_subnet_group_id"></a> [subnet\_group\_id](#output\_subnet\_group\_id) | The ElastiCache subnet group ID |
| <a name="output_subnet_group_name"></a> [subnet\_group\_name](#output\_subnet\_group\_name) | The ElastiCache subnet group name |
| <a name="output_transit_encryption_enabled"></a> [transit\_encryption\_enabled](#output\_transit\_encryption\_enabled) | Whether encryption in transit is enabled |
<!-- END_TF_DOCS -->
