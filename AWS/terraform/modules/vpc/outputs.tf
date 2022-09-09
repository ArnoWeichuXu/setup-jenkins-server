output "public_subnet_id" {
  description = "The public subnet ID assigned to the Jenkins serve"
  value       = aws_subnet.vpc_subnet.id
}

output "vpc_id" {
  description = "The VPC ID for the project"
  value       = aws_vpc.main.id
}