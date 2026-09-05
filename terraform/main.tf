resource "aws_instance" "netflix" {
  ami           = var.ami_id
  instance_type = var.instance_type

  subnet_id = var.subnet_id

  key_name = var.key_name

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name        = "netflix-devsecops"
    Environment = "dev"
    Project     = "Netflix-DevSecOps"
    ManagedBy   = "Terraform"
  }
}
