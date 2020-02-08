resource "aws_cloudwatch_event_rule" "bot_event" {
  name_prefix         = var.bot_event_prefix
  schedule_expression = var.bot_event_schedule
}

resource "aws_cloudwatch_event_target" "bot_event" {
  rule  = aws_cloudwatch_event_rule.bot_event.id
  arn   = aws_lambda_function.bot.arn
  input = "{\"url\":\"https://www.google.com\"}"
}

resource "aws_lambda_permission" "bot_event" {
  statement_id_prefix = var.bot_event_permission_prefix
  action              = "lambda:InvokeFunction"
  function_name       = aws_lambda_function.bot.function_name
  principal           = "events.amazonaws.com"
  source_arn          = aws_cloudwatch_event_rule.bot_event.arn
}
