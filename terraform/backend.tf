terraform {
  backend "s3" {
    bucket       = "yogesh-terraform-state-620745274545"
    key          = "enterprise/dev/terraform.tfstate"
    region       = "ap-south-1"
    encrypt      = true
    use_lockfile = true
  }
}