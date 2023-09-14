# Variables Configuration

variable "default_tags" {
  default = {
    "Created By"       = "QuyenNV9",
    "Impact"           = "High",
    "Project"          = "vtidemo",
    "Env"              = "Prod",
    "Last Modified By" = "QuyenNV9"
    "Maintenance By"   = "Terraform"
  }
  description = "Additional resource tags"
  type        = map(string)
}
variable "custom_prefix" {
  description = "The prefix for identity resources by individual"
  type = "string"
  default = "hieunq"
}
variable "trusted_ips" {
  description = "The public ip of administrator"
  type        = string
  default     = "118.70.52.203/32"
}

variable "vpc_cidr" {
  default     = "10.20.0.0/16"
  type        = string
  description = "The VPC Subnet CIDR"
}

#ecs varible
variable "az_count" {
  description = "Number of AZs to cover in a given AWS region"
  default     = "3"
}
variable "ecs_cluster_definition" {
  description = "The definition of ECS"
  type = map(object({
    ecs_cluster_name                = string
    ecs_capacity_providers          = string
    ecs_desired_count               = number
    ecs_network_mode                = string
    cpu_request                     = number
    memory_request                  = number
    essential                       = bool
    image_url                       = string
    container_port                  = number
    enable_application_loadbalancer = bool
    cw_log_group                    = string
    cw_log_stream                   = string
    enable_auto_scaling             = bool
    min_capacity                    = number
    max_capacity                    = number
  }))
  default = {
    "app" = {
      ecs_cluster_name                = "vti-app-fargate-cluster"
      ecs_capacity_providers          = "FARGATE"
      container_port                  = 8080
      cpu_request                     = 256
      memory_request                  = 512
      cw_log_group                    = "vtidemo-app"
      cw_log_stream                   = "vtidemo-app-fargate"
      ecs_desired_count               = 1
      ecs_network_mode                = "awsvpc"
      enable_application_loadbalancer = true
      essential                       = true
      image_url                       = "639136264313.dkr.ecr.ap-southeast-1.amazonaws.com/demo-app:1"
      enable_auto_scaling             = true
      min_capacity                    = 1
      max_capacity                    = 9
    }
  }
}

#database variable

variable "rds_cluster_definition" {
  description = "The definition of rds"
  type = map(object({
    db_indentifier                      = string
    db_engine                           = string
    db_engine_version                   = string
    db_instance_class                   = string
    allocated_storage                   = number
    max_allocated_storage               = number
    db_name                             = string
    db_username_login                   = string
    db_port                             = string
    iam_database_authentication_enabled = bool
    multi_az                            = bool
    backup_retention_period             = number
    db_parameter_family_group           = string
    major_engine_version                = string
    deletion_protection                 = bool
    cross_region_replica                = bool
    publicly_accessible                 = bool
    apply_immediately                   = bool
    storage_encrypted                   = bool
    storage_type                        = string
    delete_automated_backups            = bool
    create_db_option_group              = bool
    option_group_timeouts               = map(string)
    enable_ssm_storage_sensitive_data   = bool
  }))
  default = {
    "mysql" = {
      db_indentifier                      = "vtiappservices"
      db_engine                           = "mariadb"
      db_engine_version                   = "10.5.12"
      db_instance_class                   = "db.t2.medium"
      allocated_storage                   = 50
      max_allocated_storage               = 100
      db_name                             = "vtiappdb"
      db_username_login                   = "vtiappdbadmin"
      db_port                             = "3306"
      iam_database_authentication_enabled = false
      multi_az                            = false
      backup_retention_period             = 30
      db_parameter_family_group           = "mariadb10.5"
      major_engine_version                = "10.5"
      deletion_protection                 = false #for dev mode
      cross_region_replica                = false
      publicly_accessible                 = false
      apply_immediately                   = true
      storage_encrypted                   = true
      storage_type                        = "gp2"
      delete_automated_backups            = true
      create_db_option_group              = false
      option_group_timeouts = {
        "delete" : "5m"
      }
      enable_ssm_storage_sensitive_data = true
    },
    "postgres" = {
      db_indentifier                      = "vticrowdservice"
      db_engine                           = "postgres"
      db_engine_version                   = "11.10"
      db_instance_class                   = "db.t2.medium"
      allocated_storage                   = 50
      max_allocated_storage               = 100
      db_name                             = "vticrowddb"
      db_username_login                   = "vtiappdbadmin"
      db_port                             = "5432"
      iam_database_authentication_enabled = false
      multi_az                            = false
      backup_retention_period             = 30
      db_parameter_family_group           = "postgres11"
      major_engine_version                = "10.5"
      deletion_protection                 = false #for dev mode
      cross_region_replica                = false
      publicly_accessible                 = false
      apply_immediately                   = true
      storage_encrypted                   = true
      storage_type                        = "gp2"
      delete_automated_backups            = true
      create_db_option_group              = false
      option_group_timeouts = {
        "delete" : "5m"
      }
      enable_ssm_storage_sensitive_data = true
    },
  }
}


#bastion variable
variable "bastion_definition" {
  description = "The definition of bastion instance"
  type = map(object({
    bastion_name                = string
    bastion_public_key          = string
    bastion_ami                 = string
    bastion_instance_class      = string
    trusted_ips                 = set(string)
    user_data_base64            = string
    associate_public_ip_address = bool
    bastion_monitoring          = bool
  }))
  default = {
    "key" = {
      associate_public_ip_address = true
      bastion_ami                 = null
      bastion_instance_class      = "t2.small"
      bastion_monitoring          = true
      bastion_name                = "vtidemo-bastion"
      bastion_public_key          = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDnLbhL8C8/q/R2dhMLLziiXGlHyBi4S0agoKr337UCcF9PYWjNlMo7HJIDXF03kxTeeYXuHLAWt8GRYLUELrtAFI/svD7Fk141RScrENz+rT9y59iYydcNPT0dFdX9YbSW7MQ6MRBKb24+yfl5Ms24zkKYVa3Ux5Lrk22gm6hJlaRN/xfQnTKn6DkwrLkhEfzWoGHiQwVtN0Ca1yC0Ofb48xShx9f+d734v61ywdpdBXkynjgfpBWtoV4WskzuCmfQuBLXWT2DCUE031bqatYaxAiao1yvFH8/4GCdVVVzcIV4JhqLm63gcEaUWgBgrUZZdJ5pCVI0H4TL+hKXJ5GfRpIYNOyL6/T+actWOLsJVdL3pJ0kBCiHrs9bhf9mzrvkyxlAx+zOac4N8JA13eJcRKYfkFDIJ0YGD/9uaMCK3TB8+SkfU54ENSp0nuHKYkUP6bK0xyV75I/OpEPx7IQAc/6+LIJBai2SjyihYsq/6a6cFpbgUIIsIHm9YCmoN90= nulled@nulled.local"
      trusted_ips                 = ["116.104.61.170/32", "8.21.11.227/32"]
      user_data_base64            = null
    }
  }
}
