resource "aws_lb" "task2-alb" {
  name               = "task2-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ALBAccess.id]
  subnets            = module.vpc.public_subnets

  enable_deletion_protection = false # В продакшене лучше true

  tags = {
    Name = "task2-alb"
  }
}

resource "aws_lb_target_group" "task2-tg" {
  name     = "task2-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id
  target_type = "ip" # Обязательно для Fargate

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = "task2-tg"
  }
}

resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.task2-alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.task2-tg.arn
  }
}

