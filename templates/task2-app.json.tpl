[
  {
    "essential": true,
    "memory": 256,
    "name": "task2-container",
    "cpu": 256,
    "image": "${REPOSITORY_URL}:${APP_VERSION}",
    "portMappings": [
      {
        "name": "web",
        "containerPort": 80,
        "hostPort": 80,
        "protocol": "tcp",
        "appProtocol": "http"
      }
    ],
    "executionRoleArn": "${EXECUTIONROLEARN}",
    "requiresCompatibilities": [
    "FARGATE"
  ]
  }
]