resource "aws_cloudwatch_log_group" "alphard" {
  name              = "/ecs/alphard"
  retention_in_days = 7
}
