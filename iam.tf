# 1. IAM Role для ECS Task Execution Role
# Эта роль позволяет сервису ECS принимать на себя эту роль,
# чтобы выполнять действия от имени вашей задачи (например, вытягивать образы ECR, отправлять логи в CloudWatch).
resource "aws_iam_role" "task2-ecs-task-execution-role" {
  name = "task2-ecs-task-execution-role"

  # Это assume_role_policy (политика доверия), которая указывает, кто может принять эту роль.
  # Для ECS Task Execution Role это всегда 'ecs-tasks.amazonaws.com'.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name = "task2-ecs-task-execution-role"
  }
}

# 2. Прикрепление управляемой политики AWS к роли
# AWS предоставляет управляемую политику 'AmazonECSTaskExecutionRolePolicy',
# которая содержит все необходимые разрешения для выполнения задач ECS.
# Это предпочтительный способ, так как AWS сам управляет разрешениями.
resource "aws_iam_role_policy_attachment" "task2-ecs-task-execution-role-policy-attachment" {
  role       = aws_iam_role.task2-ecs-task-execution-role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# 3. (Опционально) Если нужны дополнительные кастомные разрешения
# Если вам нужны дополнительные разрешения, помимо тех, что есть в AmazonECSTaskExecutionRolePolicy,
# вы можете создать свою Inline Policy или новую управляемую политику.
/*
resource "aws_iam_role_policy" "task2-ecs-custom-policy" {
  name = "task2-ecs-custom-policy"
  role = aws_iam_role.task2-ecs-task-execution-role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Resource = [
          "arn:aws:s3:::my-custom-bucket",
          "arn:aws:s3:::my-custom-bucket/*"
        ]
      }
    ]
  })
}
*/