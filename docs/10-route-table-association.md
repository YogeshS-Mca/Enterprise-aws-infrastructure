# Phase 10 - Route Table Association

## Objective

Associate the Public Subnet with the Public Route Table.

---

## Why is Route Table Association Required?

A Route Table exists independently from a subnet.

AWS requires an explicit association between a subnet and a Route Table before routing rules apply to that subnet.

---

## Business Scenario

A public web server is deployed inside a public subnet.

The subnet must use a Route Table that contains a route to the Internet Gateway.

Without this association, internet connectivity is not possible.

---

## Expected Result

- Public Route Table associated with Public Subnet
- Public Subnet now follows Internet routing rules

---

## Learning Outcome

- Learned how Route Tables are attached to subnets
- Understood why association is required
- Configured subnet routing using Terraform