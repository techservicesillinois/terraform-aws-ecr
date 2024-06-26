variable "disable_lifecycle_policy" {
  description = "If true, no lifecycle policy is applied."
  default     = false
}

variable "lambda_arns" {
  description = "List of lambda ARNs that can pull images."
  type        = list(string)
  default     = []
}

variable "lifecycle_policy_path" {
  description = "Path to JSON document containing lifecycle policy."
  default     = null
}

variable "readers" {
  description = "List of account ARNs that can pull images. These accounts are also granted describe and list access to the corresponding repo(s) and images."
  type        = list(string)
  default     = []
}

variable "repos" {
  description = "List of ECR repository names."
  type        = list(string)
}

variable "tags" {
  description = "Map of tags for resources where supported"
  type        = map(string)
  default     = {}
}

variable "writers" {
  description = "List of account ARNs that can push images."
  type        = list(string)
  default     = []
}

# Debugging.

variable "_debug" {
  description = "Produce debug output (boolean)"
  type        = bool
  default     = false
}
