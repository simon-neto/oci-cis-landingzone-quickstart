## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| oci | n/a |

## Modules

No Modules.

## Resources

| Name |
|------|
| [oci_identity_policy](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/identity_policy) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| policies | n/a | <pre>map(object({<br>    compartment_id = string  <br>    description    = string,<br>    statements     = list(string)<br>  }))</pre> | n/a | yes |

## Outputs

No output.
