locals {
  bot_package_path = "${path.root}/src/dist/output.zip"
}

resource "aws_lambda_function" "bot" {
  function_name    = var.bot_function_name
  filename         = local.bot_package_path
  role             = aws_iam_role.bot.arn
  handler          = "index.handler"
  source_code_hash = filebase64sha256(local.bot_package_path)
  runtime          = "nodejs10.x"
  publish          = true
  memory_size      = var.bot_function_memory_size

  layers = [aws_lambda_layer_version.chrome_layer.arn]
}

resource "aws_cloudwatch_log_group" "bot" {
  name = "/aws/lambda/${var.bot_function_name}"
}

resource "aws_iam_role" "bot" {
  name_prefix        = var.bot_role_name_prefix
  assume_role_policy = data.aws_iam_policy_document.bot-assume-role-policy.json
}

resource "aws_iam_role_policy" "bot" {
  role   = aws_iam_role.bot.id
  policy = data.aws_iam_policy_document.bot-permission-policy.json
}

data "aws_iam_policy_document" "bot-assume-role-policy" {
  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRole"
    ]
    principals {
      type = "Service"
      identifiers = [
        "lambda.amazonaws.com"
      ]
    }
  }
}

data "aws_iam_policy_document" "bot-permission-policy" {
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = [aws_cloudwatch_log_group.bot.arn]
  }
}
