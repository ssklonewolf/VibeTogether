variable "aks" {
  type = map(object({
    name = string
    location=string
    resource_group_name=string
    dns_prefix=optional(string)
      default_node_pool =object({
        name = string
        node_count=number
        vm_size=string
      })
     identity =object({
       type = string
     })
     tags=map(string)
    azure_policy_enabled=bool
    azure_policy_enabled=object({
       network_plugin=string
       network_policy=optional(string)
    })
  }))
}