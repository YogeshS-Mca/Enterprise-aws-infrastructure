## Terraform Resource

```hcl
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
}
```

## Commands Executed

- terraform fmt
- terraform validate
- terraform plan
- terraform apply

## Result

A public Route Table was successfully created and configured with a default route (`0.0.0.0/0`) pointing to the Internet Gateway.