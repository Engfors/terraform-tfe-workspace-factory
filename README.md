# Terraform Cloud / Enterprise Workspace Module

A Terraform module which creates Workspace on Terraform Cloud / Enterprise with the following characteristics:

- Ability to configure all kind of Variables (HCL, Non HCL, Sensitive, Non Sensitive, Terraform or ENV)
- Allow to enable or not notification at the workspace level
- Allow you to choose to enable vcs connection at the workspace level

## Terraform versions

Tested with Terraform 1.0.11.

## Usage

*Note: Attributes followed by [default] is not required and can be skipped if no change to the value is needed.*

Workspace **with** notification and vcs example:


```hcl

module "demo_workspace" {
  source   = "./modules/terraform-terraform-workspace-factory"

  workspace = [
      {
        "name"                  = "project_with_vcs"
        "organization"          = "test_organization"
        "tf_version"            = "1.0.11"
        "auto_apply"            = false [default]
        "file_triggers_enabled" = false [default]
        "operations"            = true [default]
        "ssh_key_id"            = "" [default]
        "trigger_prefixes"      = [] [default]
        "working_directory"     = "" [default]
        "queue_all_runs"        = false [default]
      }
    ]

    vcs_configuration = [
        {
          "identifier"         = "organisation/repo"
          "branch"             = "main"
          "oauth_token_id"     = "ot-21hhhabcdefoia123"
          "ingress_submodules" = false [default]
        }
    ]

    workspace_variables = [
      {
        key       = "mykey"
        value     = "myvalue"
        category  = "terraform"
        hcl       = "false"
        sensitive = "false"
      }
    ]

    workspace_variables = {
      "mykey" = {
        value       = "myvalue"
        category    = "terraform"
        hcl         = "false"
        sensitive   = "false"
      }
    }

    notification_configuration = [
      {
        "name"             = "test_notifaction"
        "enabled"          = true
        "token"            = "my_token"
        "destination_type" = "slack"
        "url"              = "https://hooks.slack.com/services/AB1C2SE98/AB1C2SE98/21hhhabcdefoia123"
        "triggers"         = "run:needs_attention"
      }
    ]
}
```

Workspace **without** notification and vcs example:

```hcl

module "demo_workspace" {
  source   = "./modules/terraform-terraform-workspace-factory"

  workspace = [
            {
        "name"                  = "project_without_vcs"
        "organization"          = "test_organization"
        "tf_version"            = "1.0.11"
        "auto_apply"            = false [default]
        "file_triggers_enabled" = false [default]
        "operations"            = true [default]
        "ssh_key_id"            = "" [default]
        "trigger_prefixes"      = [] [default]
        "working_directory"     = "" [default]
        "queue_all_runs"        = false [default]
      }
    ]

    workspace_variables = {
      "mykey" = {
        value       = "myvalue"
        category    = "terraform"
        hcl         = "false"
        sensitive   = "false"
      }
    }

}
```

## Authors

- **Emil Engfors** - *Initial work*
