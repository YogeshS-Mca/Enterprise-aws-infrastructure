output "state_bucket_name" {
  description = "Name of the S3 bucket used for Terraform remote state"
  value       = aws_s3_bucket.terraform_state.id
}

output "state_bucket_region" {
  description = "AWS region of the Terraform state bucket"
  value       = aws_s3_bucket.terraform_state.region
}

output "versioning_status" {
  description = "Versioning status of the Terraform state bucket"
  value       = aws_s3_bucket_versioning.terraform_state.versioning_configuration[0].status
}