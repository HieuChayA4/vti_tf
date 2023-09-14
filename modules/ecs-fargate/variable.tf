variable "ecs_cluster_name" {}
variable "ecs_desired_count" {}
variable "ecs_network_mode" {}
variable "cpu_request" {}
variable "memory_request" {}
variable "ecs_capacity_providers" {}
variable "essential" {}
variable "image_url" {}
variable "container_port" {}
variable "cw_log_group" {}
variable "cw_log_stream" {}
variable "enable_application_loadbalancer" {}
variable "enable_scaling" {}
variable "min_capacity" {}
variable "max_capacity" {}
variable "current_region" {}
variable "default_tags" {}
variable "vpc_id" {}
variable "public_subnet_ids" {}
variable "private_subnet_ids" {}
variable "custom_prefix" {}
