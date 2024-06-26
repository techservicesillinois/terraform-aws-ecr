locals {
  actions_read = [
    "ecr:BatchCheckLayerAvailability",
    "ecr:BatchGetImage",
    "ecr:DescribeImages",
    "ecr:DescribeRepositories",
    "ecr:GetDownloadUrlForLayer",
    "ecr:ListImages",
  ]
  actions_write = [
    "ecr:BatchCheckLayerAvailability",
    "ecr:CompleteLayerUpload",
    "ecr:GetDownloadUrlForLayer",
    "ecr:InitiateLayerUpload",
    "ecr:PutImage",
    "ecr:UploadLayerPart",
  ]
}

# https://docs.aws.amazon.com/AmazonECR/latest/userguide/RepositoryPolicyExamples.html#IAM_allow_other_accounts

data "aws_iam_policy_document" "default" {
  statement {
    sid = "ECRImageCrossAccountBasic"
    principals {
      type        = "AWS"
      identifiers = local.identifiers
    }

    actions = local.actions
  }

  dynamic "statement" {
    for_each = toset(length(var.lambda_arns) > 0 ? [""] : [])

    content {
      sid = "ECRImageCrossAccountLambda"
      principals {
        type        = "Service"
        identifiers = ["lambda.amazonaws.com"]
      }

      actions = [
        "ecr:BatchGetImage",
        "ecr:GetDownloadUrlForLayer",
      ]

      condition {
        test     = "StringLike"
        variable = "aws:sourceArn"
        values   = var.lambda_arns
      }
    }
  }
}
