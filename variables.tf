# variables.tf

variable "aws_region" {
  description = "The AWS region to create resources in"
  type        = string
  default     = "us-east-1"
}

variable "docker_image_selection" {
  description = "The Docker image to use for the Lambda function"
  type        = string

}

variable "lambda_function_name" {
  description = "The Docker image to use for the Lambda function"
  type        = string

}

variable "lambda_suffix" {
  description = "A unique suffix for the Lambda function name"
  type        = string
}
