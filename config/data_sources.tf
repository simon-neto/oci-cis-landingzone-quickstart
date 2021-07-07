# Copyright (c) 2020 Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.

data "oci_identity_regions" "these" {}

data "oci_identity_tenancy" "this" {
  tenancy_id = var.tenancy_ocid
}

data "oci_cloud_guard_targets" "root" {
  compartment_id = var.tenancy_ocid
}

data "oci_cloud_guard_cloud_guard_configuration" "cloud_guard_config" {
  compartment_id = var.tenancy_ocid
}
