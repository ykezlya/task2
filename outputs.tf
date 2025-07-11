
output vpc_id {
  value       = module.vpc.vpc_id
  sensitive   = false
  description = "VPC ID of the created VPC"
  depends_on  = []
}

output aws_lb {
  value       = aws_lb.task2-alb.dns_name
  sensitive   = false
  description = "ALB created for task2"
  depends_on  = [aws_lb_listener.http_listener]
}