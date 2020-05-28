# terraform-chainlink-aws-node

[![open-issues](https://img.shields.io/github/issues-raw/insight-infrastructure/terraform-chainlink-aws-node?style=for-the-badge)](https://github.com/insight-infrastructure/terraform-chainlink-aws-node/issues)
[![open-pr](https://img.shields.io/github/issues-pr-raw/insight-infrastructure/terraform-chainlink-aws-node?style=for-the-badge)](https://github.com/insight-infrastructure/terraform-chainlink-aws-node/pulls)

## Features

This module deploys a node on chainlink.

## Terraform Versions

For Terraform v0.12.0+

## Usage

```
module "this" {
    source = "github.com/insight-infrastructure/terraform-chainlink-aws-node"

}
```
## Examples

- [defaults](https://github.com/insight-infrastructure/terraform-chainlink-aws-node/tree/master/examples/defaults)

## Known  Issues
No issue is creating limit on this module.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| random | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| ansible\_hardening | Run hardening roles | `bool` | `false` | no |
| associate\_eip | Boolean to determine if you should associate the ip when the instance has been configured | `bool` | `true` | no |
| create | Boolean to create resources or not | `bool` | `true` | no |
| create\_ebs\_volume | #### EBS #### | `bool` | `false` | no |
| ebs\_volome\_iops | n/a | `string` | n/a | yes |
| ebs\_volume\_id | The volume id of the ebs volume to mount | `string` | `""` | no |
| ebs\_volume\_size | The size of volume - leave as zero or empty for no volume | `number` | `0` | no |
| ebs\_volume\_type | Type of EBS - https://aws.amazon.com/ebs/volume-types/ | `string` | `"gp2"` | no |
| instance\_type | Instance type | `string` | `"t2.micro"` | no |
| key\_name | The key pair to import - leave blank to generate new keypair from pub/priv ssh key path | `string` | `""` | no |
| keystore\_password | The password to the keystore | `string` | `""` | no |
| keystore\_path | The path to the keystore | `string` | `""` | no |
| logging\_bucket\_name | Name of bucket for logs - blank for logs-<account-id> | `string` | `""` | no |
| logs\_bucket\_enable | Create bucket to put logs | `bool` | `false` | no |
| minimum\_specs | Boolean to use minimum specs | `bool` | `false` | no |
| monitoring | Boolean for cloudwatch | `bool` | `false` | no |
| name | The name for the label | `string` | `"prep"` | no |
| network\_name | The network name, ie kusama / mainnet | `string` | `"testnet"` | no |
| playbook\_vars | Additional playbook vars | `map(string)` | `{}` | no |
| private\_key\_path | The path to the private ssh key | `string` | n/a | yes |
| public\_ip | The public IP of the elastic ip to attach to active instance | `string` | `""` | no |
| public\_key\_path | The path to the public ssh key | `string` | n/a | yes |
| root\_iops | n/a | `string` | n/a | yes |
| root\_volume\_size | Root volume size | `string` | `8` | no |
| root\_volume\_type | n/a | `string` | `"gp2"` | no |
| subnet\_id | The id of the subnet | `string` | n/a | yes |
| tags | Map of tags | `map(string)` | `{}` | no |
| volume\_path | The path of the EBS volume | `string` | `"/dev/xvdf"` | no |
| vpc\_security\_group\_ids | List of security groups | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| dhcp\_ip | n/a |
| ebs\_volume\_arn | n/a |
| instance\_id | n/a |
| instance\_store\_enabled | n/a |
| instance\_type | n/a |
| key\_name | n/a |
| network\_name | n/a |
| public\_ip | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Testing
This module has been packaged with terratest tests

To run them:

1. Install Go
2. Run `make test-init` from the root of this repo
3. Run `make test` again from root

## Authors

Module managed by [insight-infrastructure](https://github.com/insight-infrastructure)

## Credits

- [Anton Babenko](https://github.com/antonbabenko)

## License

Apache 2 Licensed. See LICENSE for full details.