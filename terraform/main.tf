resource "aws_s3_bucket" "terraform_demo" {
  bucket = "yogesh-terraform-demo-2026"

  tags = {
    Name        = "Terraform Demo Bucket"
    Environment = "Learning"
    Project     = "Enterprise AWS Infrastructure"
  }
}