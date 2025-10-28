variable "rg" {
  type = map(object({
    name = string
    location = string
    managed_by = optional(string, null)
    tags = optional(map(string),{})
  }))
}