# reflex-aws-kms-key-deletion-scheduled
Reflex Rule for detecting and preventing KMS Key deletion.

## Usage
To use this rule either add it to your `reflex.yaml` configuration file:  
```
rules:
  - reflex-aws-kms-key-deletion-scheduled:
      version: latest
```

or add it directly to your Terraform:  
```
...

module "reflex-aws-kms-key-deletion-scheduled" {
  source           = "github.com/cloudmitigator/reflex-aws-kms-key-deletion-scheduled"
}

...
```

## License
This Reflex rule is made available under the MPL 2.0 license. For more information view the [LICENSE](https://github.com/cloudmitigator/reflex-aws-kms-key-deletion-scheduled/blob/master/LICENSE) 
