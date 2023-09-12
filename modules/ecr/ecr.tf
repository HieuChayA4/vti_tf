resource "aws_ecr_repository" "image_repo" {
  name                 = var.ecs_cluster_name
  image_tag_mutability = "IMMUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
}
#===================================================
# OUTPUT
#===================================================
output "ecr_repository_arn" {
  value = aws_ecr_repository.image_repo.arn
}
