# ecr

[![Terraform actions status](https://github.com/techservicesillinois/terraform-aws-ecr/workflows/terraform/badge.svg)](https://github.com/techservicesillinois/terraform-aws-ecr/actions)

Provides an [Elastic Container Registry repository](https://docs.aws.amazon.com/AmazonECR/latest/userguide/ECR_GetStarted.html). In addition, it provides an optional default lifecycle
policy.

[Cross-account](https://aws.amazon.com/premiumsupport/knowledge-center/secondary-account-access-ecr/)
access may be enabled by setting the `readers` or `writers` arguments.

Example Usage
-----------------

```hcl
module "foo" {
  source = "git@github.com:techservicesillinois/terraform-aws-ecr"

  lambda_arns = ["arn:aws:lambda:us-east-1: 874445906176:function:*"]
  repos = [
    "repo_name_1",
    "repo_name_2",
  ]
  readers = ["arn:aws:iam::874445906176:root"]
}
```

Argument Reference
-----------------

The following arguments are supported:

* `disable_lifecycle_policy` - (Optional) If set to 'true', no lifecycle policy is applied. Default is 'false'.

* `lambda_arns` – (Optional) List of lambda function ARNs that can pull images at launch.

* `lifecycle_policy_path` – (Optional) Path to JSON document containing lifecycle policy.

* `readers` - (Optional) List of account ARNs that can pull images. These accounts are also granted describe and list access to the corresponding repo(s) and images.

* `repos` - (Required) List of repository names.

* `tags` - (Optional) Map of tags for resources where supported.

* `writers` - (Optional) List of account ARNs that can push images.

### Debugging

* `_debug` - (Optional) If set, produce verbose output for debugging.

Attributes Reference
--------------------

The following attribute is exported:

* `repos` - Map wherein each key/value pair consists of a repo name and URL.
