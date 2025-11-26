resource "aws_ecs_service" "alphard" {
  name            = "alphard-service"
  cluster         = aws_ecs_cluster.alphard.id
  task_definition = aws_ecs_task_definition.alphard.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = data.aws_subnets.default.ids
    security_groups = [aws_security_group.alphard_service.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.alphard.arn
    container_name   = "alphard"
    container_port   = 8000
  }

  depends_on = [
    aws_lb_listener.alphard_http
  ]
}
