resource "aws_cloudwatch_event_rule" "this_start" {
  name                = "${module.label.id}-start"
  description         = "Execute EC2 start lambda function mon-fri AM9:00(JST)"
  schedule_expression = "cron(0 0 ? * MON-FRI *)"
}

resource "aws_cloudwatch_event_rule" "this_stop" {
  name                = "${module.label.id}-stop"
  description         = "Execute EC2 stop lambda function mon-fri PM7:00(JST)"
  schedule_expression = "cron(0 10 ? * MON-FRI *)"
}

resource "aws_cloudwatch_event_target" "this_start" {
  rule = "${aws_cloudwatch_event_rule.this_start.name}"
  arn  = "${aws_lambda_function.this.arn}"

  input = <<INPUT
{"Action": "Start"}
INPUT
}

resource "aws_cloudwatch_event_target" "this_stop" {
  rule = "${aws_cloudwatch_event_rule.this_stop.name}"
  arn  = "${aws_lambda_function.this.arn}"

  input = <<INPUT
{"Action": "Stop"}
INPUT
}

resource "aws_cloudwatch_log_group" "this" {
  name              = "/aws/lambda/${aws_lambda_function.this.function_name}"
  retention_in_days = 30
}
