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

  name = "repoName"
  writers = ["arn:aws:iam::874445906176:root"]
}
```

Argument Reference
-----------------

The following arguments are supported:

* `name` - (Required) Name of the repository.

* `disable_lifecycle_policy` - (Optional) If set to 'true', no lifecycle policy is applied. Default is 'false'.

* `lifecycle_policy_path` – (Optional) Path to JSON document containing lifecycle policy.

* `readers` - (Optional) List of account ARNs that can pull images.

* `writers` - (Optional) List of account ARNs that can push images.

* `tags` - (Optional) Map of tags for resources where supported.

Attributes Reference
--------------------

The following attributes are exported:

* `arn` - Full ARN of the repository.
* `name` - The name of the repository.
* `registry_id` - The registry ID where the repository was created.
* `repository_url` - The URL of the repository (in the form
    `aws_account_id.dkr.ecr.region.amazonaws.com/repositoryName`).
