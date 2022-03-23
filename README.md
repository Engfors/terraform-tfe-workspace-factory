# Terraform Cloud / Enterprise Workspace Module

A Terraform module which creates Workspace on Terraform Cloud / Enterprise with the following characteristics:

- Ability to configure all kind of Variables (HCL, Non HCL, Sensitive, Non Sensitive, Terraform or ENV)
- Allow to enable or not notification at the workspace level
- Allow you to choose to enable vcs connection at the workspace level

## Terraform versions

Tested with Terraform 1.0.11.

## Usage

Workspace **with** notification and vcs example:

```hcl

module "demo_workspace" {
  source   = "./modules/terraform-terraform-workspace-factory"

  workspace = [
      {
        "name"                  = "project_with_vcs"
        "organization"          = "test_organization"
        "auto_apply"            = false
        "file_triggers_enabled" = false
        "operations"            = true
        "ssh_key_id"            = ""
        "trigger_prefixes"      = "folder/"
        "working_directory"     = "folder"
        "tf_version"            = "1.0.11"
        "queue_all_runs"        = false

      }
    ]

    vcs_configuration = [
        {
          "identifier"         = "organisation/repo"
          "branch"             = "main"
          "ingress_submodules" = false
          "oauth_token_id"     = "ot-21hhhabcdefoia123"
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
        "auto_apply"            = false
        "file_triggers_enabled" = false
        "operations"            = true
        "ssh_key_id"            = ""
        "trigger_prefixes"      = ""
        "working_directory"     = ""
        "tf_version"            = "1.0.11"
        "queue_all_runs"        = false

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
