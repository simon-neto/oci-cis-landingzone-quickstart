# Copyright (c) 2020 Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.

module "cis_cloud_guard" {
  #adding the logical condition to the count in case cloud guard is already enabled
  count                 = length(data.oci_cloud_guard_targets.root.target_collection[0].items) > 0 ? (data.oci_cloud_guard_targets.root.target_collection[0].items[0].display_name == local.cg_target_name ? (local.cloud_guard_status ? 1 : 0) : 0): 1
  #count                 = length(data.oci_cloud_guard_targets.root.target_collection[0].items) > 0 ? (data.oci_cloud_guard_targets.root.target_collection[0].items[0].display_name == local.cg_target_name ? 1 : 0): 1
  #count                 = length(data.oci_cloud_guard_targets.root.target_collection[0].items) > 0 ? ((data.oci_cloud_guard_targets.root.target_collection[0].items[0].display_name == local.cg_target_name && local.could_guard_status)? 1 : 0) : 1
  depends_on            = [ null_resource.slow_down_cloud_guard ]
  source                = "../modules/monitoring/cloud-guard"
  providers             = { oci = oci.home }
  compartment_id        = var.tenancy_ocid
  #Changes to accomodate the corner case when the Cloud Guard reporting region is different from Home Region
  #reporting_region      = local.regions_map[local.home_region_key]
  reporting_region      = local.local_reporting_region
  status                = var.cloud_guard_configuration_status
  self_manage_resources = false
  default_target        = {name:local.cg_target_name, type:"COMPARTMENT", id:var.tenancy_ocid} 
}
### We've observed that policies, even when created before the bucket, may take some time to be available for consumption. Hence the delay introduced here.
resource "null_resource" "slow_down_cloud_guard" {
   depends_on = [ module.lz_cloud_guard_policies ]
   provisioner "local-exec" {
     command = "sleep 30" # Wait 30 seconds for policies to be available.
   }
}