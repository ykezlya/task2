variable "AWS_REGION" {
    description = "The AWS region where resources will be created"
    type        = string
    default     = "eu-west-1"
}

variable "STATE_BACKET_NAME" {
    description = "The name of the S3 bucket for storing Terraform state"
    type        = string
    default     = "terraform-state-bucket-task2"
}