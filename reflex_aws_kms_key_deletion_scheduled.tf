module "reflex_aws_kms_key_deletion_scheduled" {
  source           = "git::https://github.com/cloudmitigator/reflex-engine.git//modules/cwe_lambda?ref=v0.5.8"
  rule_name        = "KMSKeyDeletionScheduled"
  rule_description = "Reflex Rule for detecting and preventing KMS Key deletion."

  event_pattern = <<PATTERN
{
  "source": [
    "aws.kms"
  ],
  "detail-type": [
    "AWS API Call via CloudTrail"
  ],
  "detail": {
    "eventSource": [
      "kms.amazonaws.com"
    ],
    "eventName": [
      "ScheduleKeyDeletion"
    ]
  }
}
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
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "kms:CancelKeyDeletion"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF

  queue_name    = "KMSKeyDeletionScheduled"
  delay_seconds = 0

  target_id = "KMSKeyDeletionScheduled"

  sns_topic_arn  = var.sns_topic_arn
  sqs_kms_key_id = var.reflex_kms_key_id
}
