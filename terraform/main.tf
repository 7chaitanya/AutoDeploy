provider "aws" {
  region = "us-east-1"
}

resource "aws_lambda_function" "demo_service" {
  function_name = "demo-service-e"
  filename      = "auto-deploy.zip"
  handler       = "index.handler"
  runtime       = "nodejs18.x"
  role          = "arn:aws:iam::612572392212:role/AWSLambdaExecutionRole"
  source_code_hash = filebase64sha256("auto-deploy.zip")
}

resource "aws_cloudwatch_metric_alarm" "lambda_errors" {
  alarm_name          = "DemoServiceErrors"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "Errors"
  namespace           = "AWS/Lambda"
  period              = "60"
  statistic           = "Sum"
  threshold           = "1"
  alarm_description   = "Alarm when Lambda errors exceed 1"
  dimensions = {
    FunctionName = aws_lambda_function.demo_service.function_name
  }
}