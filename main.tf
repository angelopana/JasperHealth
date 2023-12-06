terraform {
    required_providers {
      aws = {
        source = "hashicorp/aws"
        version = "~> 5.25.0"
      }
    }
}

provider "aws" {
    region = "us-east-2"
    access_key = var.access_key
    secret_key = var.secret_access_key
}

# Iam role for Lambda
resource "aws_iam_role" "iam_for_lambda" {

    name = "iam_for_lambda"

    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [{
            Action = "sts:AssumeRole"
            Effect = "Allow"
            Sid = ""
            Principal = {
                Service = "lambda.amazonaws.com"
            }
        }]
    })

}

# Policy for the IAM role
resource "aws_iam_policy" "iam_policy_for_lambda" { 
    name = "iam_policy_for_lambda"
    path = "/"
    description = "AWS IAM Policy for lambda, test for Jasper"
    policy = jsonencode({ 
        "Version": "2012-10-17",
        "Statement": [
            {
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
        "Resource": "arn:aws:logs:*:*:*",
        "Effect": "Allow"
    }]})
}

# Attach policy for the IAM role
resource "aws_iam_role_policy_attachment" "attach_iam_policy_to_role" {
    role = aws_iam_role.iam_for_lambda.name
    policy_arn = aws_iam_policy.iam_policy_for_lambda.arn 
}


# Zip our handler code
data "archive_file" "go_code_zip" {
    type = "zip"
    source_dir = "${path.module}/python"
    output_path ="${path.module}/python/hello-world.zip"
}

resource "aws_lambda_function" "jasper_health_lambda_function" {
  filename = "${path.module}/python/hello-world.zip"
  function_name = "jasper_health_lambda_function"
  role = aws_iam_role.iam_for_lambda.arn
  handler = "hello-world.handler"
  runtime = "python3.11"
  depends_on = [ aws_iam_role_policy_attachment.attach_iam_policy_to_role ]

}


resource "aws_lambda_function_url" "lambda_function_url" { 
    function_name = aws_lambda_function.jasper_health_lambda_function.arn
    authorization_type = "NONE"
}

output "function_url" {
    description = "Demo Fucntion URL"
    value = aws_lambda_function_url.lambda_function_url.function_url
}

