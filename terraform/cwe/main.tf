module "cwe" {
  source      = "git::https://github.com/cloudmitigator/reflex-engine.git//modules/cwe_lambda?ref=v0.6.0"
  name        = "KMSKeyDeletionScheduled"
  description = "Reflex Rule for detecting and preventing KMS Key deletion."

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

}
