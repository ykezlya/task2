resource "aws_ecs_cluster" "task2-cluster" {
  name = "task2-cluster"
}

resource "aws_ecs_task_definition" "task2-definition" {
family = "task2"
requires_compatibilities = ["FARGATE"]
network_mode = "awsvpc"
cpu = "1024"
memory = "3072"
execution_role_arn = aws_iam_role.task2-ecs-task-execution-role.arn
container_definitions = templatefile("templates/task2-app.json.tpl", {
  REPOSITORY_URL = replace(aws_ecr_repository.task2_myapp.repository_url, "https://", ""),
  EXECUTIONROLEARN = aws_iam_role.task2-ecs-task-execution-role.arn,
  APP_VERSION    = var.MYAPP_VERSION
})
}

resource "aws_ecs_service" "task2-service" {
  count           = var.MYAPP_SERVICE_ENABLE
  name            = "task2-service"
  cluster         = aws_ecs_cluster.task2-cluster.id
  task_definition = aws_ecs_task_definition.task2-definition.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = module.vpc.private_subnets
    security_groups  = [aws_security_group.AccessToEndpoints.id, aws_security_group.ECSAccess.id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.task2-tg.arn
    container_name   = "task2-container"
    container_port   = 80
  }
  depends_on = [
    aws_lb_listener.http_listener # Зависимость от слушателя
  ]
  lifecycle {
    ignore_changes = [task_definition]
  }
}

