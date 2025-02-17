# Copyright (c) 2020 Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.

### Group
resource "oci_identity_group" "this" {
  name           = var.group_name
  description    = var.group_description
  compartment_id = var.tenancy_ocid
}

data "oci_identity_users" "these" {
  compartment_id = var.tenancy_ocid
  filter {
    name   = "name"
    values = var.user_names
  }
}
### Add users to group
 resource "oci_identity_user_group_membership" "this" {
  count = data.oci_identity_users.these.users != null ? length(data.oci_identity_users.these.users) : 0
  user_id  = data.oci_identity_users.these.users[count.index].id
  group_id = oci_identity_group.this.id
}
