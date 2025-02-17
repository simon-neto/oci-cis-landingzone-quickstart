# Copyright (c) 2020 Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.

output "group_id" {
  value = oci_identity_group.this.id
}

output "group_name" {
  value = var.group_name
}
