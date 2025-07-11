resource "aws_s3_bucket" "terraform-state" {
  bucket = var.STATE_BACKET_NAME

  tags = {
    Name = "Terraform state"
  }
}

