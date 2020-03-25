module "reflex_aws_kms_key_deletion_scheduled" {
  source           = "git::https://github.com/cloudmitigator/reflex-engine.git//modules/cwe_lambda?ref=v0.5.4"
  rule_name        = "KMSKeyDeletionScheduled"
  rule_description = "TODO: Provide rule description"

  event_pattern = <<PATTERN
# TODO: Provide event pattern
PATTERN

  function_name   = "KMSKeyDeletionScheduled"
  source_code_dir = "${path.module}/source"
  handler         = "reflex_aws_kms_key_deletion_scheduled.lambda_handler"
  lambda_runtime  = "python3.7"
  environment_variable_map = {
    SNS_TOPIC = var.sns_topic_arn,
    MODE      = var.mode
  }
  custom_lambda_policy = <<EOF
# TODO: Provide required lambda permissions policy
EOF



  queue_name    = "KMSKeyDeletionScheduled"
  delay_seconds = 0

  target_id = "KMSKeyDeletionScheduled"

  sns_topic_arn  = var.sns_topic_arn
  sqs_kms_key_id = var.reflex_kms_key_id
}