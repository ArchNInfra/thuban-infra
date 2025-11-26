# Security group for ALB - allow HTTP from anywhere
resource "aws_security_group" "alphard_alb" {
  name        = "alphard-alb-sg"
  description = "ALB security group for Alphard"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Security group for ECS tasks - allow traffic from ALB only
resource "aws_security_group" "alphard_service" {
  name        = "alphard-service-sg"
  description = "ECS service security group for Alphard"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description      = "Traffic from ALB"
    from_port        = 8000
    to_port          = 8000
    protocol         = "tcp"
    security_groups  = [aws_security_group.alphard_alb.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Application Load Balancer
resource "aws_lb" "alphard" {
  name               = "alphard-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alphard_alb.id]
  subnets            = data.aws_subnets.default.ids
}

# Target group for ECS service
resource "aws_lb_target_group" "alphard" {
  name        = "alphard-tg"
  port        = 8000
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = data.aws_vpc.default.id

  health_check {
    path                = "/health"
    port                = "8000"
    protocol            = "HTTP"
    matcher             = "200"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    interval            = 30
    timeout             = 5
  }
}

# HTTP listener
resource "aws_lb_listener" "alphard_http" {
  load_balancer_arn = aws_lb.alphard.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alphard.arn
  }
}

output "alphard_alb_dns_name" {
  value = aws_lb.alphard.dns_name
}
