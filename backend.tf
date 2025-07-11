terraform {
  backend "s3" {
    bucket = "terraform-state-bucket-task2"
    key    = "terraform.tfstate"
    region = "eu-west-1"
  }
}