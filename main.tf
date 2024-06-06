# main.tf

provider "aws" {
  region = var.aws_region
}

# Generate a random string for unique naming
resource "random_string" "lambda_suffix" {
  length  = 8
  special = false
  upper   = false
}

# Generate a unique Lambda function name
locals {
  lambda_function_name = "my_lambda_function_${var.lambda_suffix}"
  iam_role_name        = "lambda_exec_role_${random_string.lambda_suffix.result}"
}

# IAM Role for Lambda execution
resource "aws_iam_role" "lambda_exec_role" {
  name = local.iam_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action    = "sts:AssumeRole",
        Effect    = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

# Attach policy to IAM role
resource "aws_iam_role_policy_attachment" "lambda_exec_policy" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# Lambda function resource
resource "aws_lambda_function" "my_lambda" {
  function_name = var.lambda_function_name
  role          = aws_iam_role.lambda_exec_role.arn
  package_type  = "Image"
  image_uri     = "058264433912.dkr.ecr.us-east-1.amazonaws.com/${var.docker_image_selection}:latest"
}

