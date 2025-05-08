output "scale_out_policy_arn" {
  value = aws_autoscaling_policy.scale_out.arn
}

output "scale_in_policy_arn" {
  value = aws_autoscaling_policy.scale_in.arn
}

output "high_cpu_alarm_name" {
  value = aws_cloudwatch_metric_alarm.cpu_high_alarm.alarm_name
}

output "low_cpu_alarm_name" {
  value = aws_cloudwatch_metric_alarm.cpu_low_alarm.alarm_name
}
