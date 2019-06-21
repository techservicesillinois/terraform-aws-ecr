# ecr

Provides an [EC2 Container Registry](https://docs.aws.amazon.com/AmazonECR/latest/userguide/ECR_GetStarted.html)
repository. In addition, it provides an optional default lifecycle
policy.

[Cross-account](https://aws.amazon.com/premiumsupport/knowledge-center/secondary-account-access-ecr/)
access may also be enabled by setting the `readers` or `writers`
arguments.

Example Usage
-----------------

```hcl
module "foo" {
  source = "git@github.com:cites-illinois/as-aws-modules//ecr"

  name = "repoName"
  writers = ["arn:aws:iam::874445906176:root"]
}
```

Argument Reference
-----------------

The following arguments are supported:

* `name` - (Required) Name of the repository.

* `disable_lifecycle_policy` - If set to 'true', no lifecycle policy is applied.

* `lifecycle_policy_path` – Path to JSON document containing lifecycle policy.

* `readers` - List of account ARNs that can pull images.

* `writers` - List of account ARNs that can push images.

Attributes Reference
--------------------

The following attributes are exported:

* `arn` - Full ARN of the repository.
* `name` - The name of the repository.
* `registry_id` - The registry ID where the repository was created.
* `repository_url` - The URL of the repository (in the form
    `aws_account_id.dkr.ecr.region.amazonaws.com/repositoryName`).
