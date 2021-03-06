# reflex-aws-kms-key-deletion-scheduled
A Reflex rule for detecting and preventing KMS Key deletion.

To learn more about the KMS Key deletion process, see [the AWS Documentation](https://docs.aws.amazon.com/kms/latest/developerguide/deleting-keys.html).

## Getting Started
To get started using Reflex, check out [the Reflex Documentation](https://docs.cloudmitigator.com/).

## Usage
To use this rule either add it to your `reflex.yaml` configuration file:  
```
rules:
  aws:
    - reflex-aws-kms-key-deletion-scheduled:
        configuration:
          mode: remediate
        version: latest
```

or add it directly to your Terraform:  
```
module "kms-key-deletion-scheduled" {
  source            = "git::https://github.com/reflexivesecurity/reflex-aws-kms-key-deletion-scheduled.git?ref=v0.1.0"
  sns_topic_arn     = module.central-sns-topic.arn
  reflex_kms_key_id = module.reflex-kms-key.key_id
  mode              = "remediate"
}
```

Note: The `sns_topic_arn` and `reflex_kms_key_id` example values shown here assume you generated resources with `reflex build`. If you are using the Terraform on its own you need to provide your own valid values.

## Configuration
This rule has the following configuration options:

<dl>
  <dt>mode</dt>
  <dd>
  <p>Sets the rule to operate in <code>detect</code> or <code>remediate</code> mode.</p>

  <em>Required</em>: No  

  <em>Type</em>: string

  <em>Possible values</em>: `detect` | `remediate`  

  <em>Default</em>: `detect`
  </dd>
</dl>

## Contributing
If you are interested in contributing, please review [our contribution guide](https://docs.cloudmitigator.com/about/contributing.html).

## License
This Reflex rule is made available under the MPL 2.0 license. For more information view the [LICENSE](https://github.com/reflexivesecurity/reflex-aws-kms-key-deletion-scheduled/blob/master/LICENSE) 
