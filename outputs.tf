output "repos" {
  value = { for r in aws_ecr_repository.default : r.name => r.repository_url }
}

# Debug outputs.

output "_actions" {
  value = (var._debug) ? local.actions : null
}

output "_identifiers" {
  value = (var._debug) ? local.identifiers : null
}
