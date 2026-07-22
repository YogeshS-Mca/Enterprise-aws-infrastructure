## Terraform Resource

```hcl
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}
```

## Commands Executed

- terraform fmt
- terraform validate
- terraform plan
- terraform apply

## Result

The Public Subnet was successfully associated with the Public Route Table. All traffic matching the route table entries will now follow those routing rules.