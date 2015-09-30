# A terraform configuration for the Taste Test

A less tedious way to set up droplets for
[the Taste Test](https://valdhaus.co/books/taste-test-puppet-chef-salt-stack-ansible.html).

Copy `terraform.tfvars.SAMPLE` to `terraform.tfvars` and set your API
key and ssh fingerprint (see the comments in `tasty.tf` for hints) and then

```
terraform plan
```

and if you're happy

```
terraform apply
```

and when you're done working

```
terraform destroy
```
