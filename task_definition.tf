resource "aws_ecs_task_definition" "alphard" {
  family                   = "alphard-task"
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  requires_compatibilities = ["FARGATE"]

  execution_role_arn = aws_iam_role.alphard_task_execution.arn
  task_role_arn      = aws_iam_role.alphard_task.arn

  container_definitions = jsonencode([
    {
      name      = "alphard"
            image     = "${aws_ecr_repository.alphard_inference.repository_url}@sha256:4d2b7fff2961df3fdd922e84e13395581e89a6daf6a73ecd1f9fe4b9dbefd8a9"

      essential = true

      portMappings = [
        {
          containerPort = 8000
          protocol      = "tcp"
        }
      ]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.alphard.name
          awslogs-region        = var.aws_region
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])
}
