# Copyright (c) 2020 Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.

### This Terraform configuration provisions groups and policies allowing the management of specific services by specific admins on specific compartments.

################################################################################
### ################## Networking Service Artifacts ############################

### Networking service group
module "cis_network_admins" {
  source                = "../modules/iam/iam-group"
  providers             = { oci = oci.home }
  tenancy_ocid          = var.tenancy_ocid
  group_name            = local.network_admin_group_name
  group_description     = "Group responsible for managing networking in compartment ${local.network_compartment_name}."
  user_names            = []
}

### Networking service policy
module "cis_network_admins_policy" {
  source                = "../modules/iam/iam-policy"
  providers             = { oci = oci.home }
  depends_on            = [module.cis_network_admins, module.cis_compartments] ### Explicitly declaring dependencies on the group and compartments modules.
  policies              = {
    ("${var.service_label}-NetworkAdmins-Policy") = {
      compartment_id         = var.tenancy_ocid
      description            = "Policy allowing ${var.service_label}-NetworkAdmins group to manage virtual-network-family in compartment ${module.cis_compartments.compartments[local.network_compartment_name].name}."
      statements             = ["Allow group ${module.cis_network_admins.group_name} to read all-resources in compartment ${local.network_compartment_name}",
                          "Allow group ${module.cis_network_admins.group_name} to manage virtual-network-family in compartment ${local.network_compartment_name}",
                          "Allow group ${module.cis_network_admins.group_name} to manage dns in compartment ${local.network_compartment_name}",
                          "Allow group ${module.cis_network_admins.group_name} to manage load-balancers in compartment ${local.network_compartment_name}",
                          "Allow group ${module.cis_network_admins.group_name} to manage alarms in compartment ${local.network_compartment_name}",
                          "Allow group ${module.cis_network_admins.group_name} to manage metrics in compartment ${local.network_compartment_name}",
                          "Allow group ${module.cis_network_admins.group_name} to manage orm-stacks in compartment ${local.network_compartment_name}",
                          "Allow group ${module.cis_network_admins.group_name} to manage orm-jobs in compartment ${local.network_compartment_name}",
                          "Allow group ${module.cis_network_admins.group_name} to manage orm-config-source-providers in compartment ${local.network_compartment_name}",
                          "Allow Group ${module.cis_network_admins.group_name} to read audit-events in compartment ${local.network_compartment_name}",
                          "Allow Group ${module.cis_network_admins.group_name} to read vss-family in compartment ${local.security_compartment_name}"]
    }
  }
}

################################################################################


################################################################################
############################ Security Service Artifacts #########################

### Security admin group
module "cis_security_admins" {
  source                = "../modules/iam/iam-group"
  providers             = { oci = oci.home }
  tenancy_ocid          = var.tenancy_ocid
  group_name            = local.security_admin_group_name
  group_description     = "Group responsible for managing security services in compartment ${local.security_compartment_name}."
  user_names            = []
}

### Security admin policy
module "cis_security_admins_policy" {
  source                = "../modules/iam/iam-policy"
  providers             = { oci = oci.home }
  depends_on            = [module.cis_security_admins, module.cis_compartments] ### Explicitly declaring dependencies on the group and compartments modules.
  policies              = {
    ("${var.service_label}-SecurityAdmins-Policy") = {
      compartment_id         = var.tenancy_ocid
      description            = "Policy allowing ${var.service_label}-SecurityAdmins group to manage security related services in compartment ${module.cis_compartments.compartments[local.security_compartment_name].name}."
      statements             = ["Allow group ${module.cis_security_admins.group_name} to read all-resources in compartment ${local.security_compartment_name}",
                          "Allow group ${module.cis_security_admins.group_name} to manage instance-family in compartment ${local.security_compartment_name}",
                          "Allow group ${module.cis_security_admins.group_name} to manage policies in tenancy where all {target.policy.name != 'Tenant Admin Policy', target.policy.name != '${var.service_label}-IAMAdmins-Policy'}",
                          "Allow group ${module.cis_security_admins.group_name} to manage policies in compartment ${local.security_compartment_name}",
                          "Allow group ${module.cis_security_admins.group_name} to manage vaults in compartment ${local.security_compartment_name}",
                          "Allow group ${module.cis_security_admins.group_name} to manage keys in compartment ${local.security_compartment_name}",
                          "Allow group ${module.cis_security_admins.group_name} to manage secret-family in compartment ${local.security_compartment_name}",
                          "Allow group ${module.cis_security_admins.group_name} to manage logging-family in compartment ${local.security_compartment_name}",
                          "Allow group ${module.cis_security_admins.group_name} to manage cloudevents-rules in tenancy",
                          "Allow group ${module.cis_security_admins.group_name} to manage serviceconnectors in compartment ${local.security_compartment_name}",
                          "Allow group ${module.cis_security_admins.group_name} to manage streams in compartment ${local.security_compartment_name}",
                          "Allow group ${module.cis_security_admins.group_name} to manage ons-family in compartment ${local.security_compartment_name}",
                          "Allow group ${module.cis_security_admins.group_name} to manage functions-family in compartment ${local.security_compartment_name}",
                          "Allow group ${module.cis_security_admins.group_name} to manage waas-family in compartment ${local.security_compartment_name}",
                          "Allow group ${module.cis_security_admins.group_name} to manage security-zone in compartment ${local.security_compartment_name}",
                          "Allow group ${module.cis_security_admins.group_name} to read virtual-network-family in compartment ${local.network_compartment_name}",
                          "Allow group ${module.cis_security_admins.group_name} to use subnets in compartment ${local.network_compartment_name}",
                          "Allow group ${module.cis_security_admins.group_name} to use network-security-groups in compartment ${local.network_compartment_name}",
                          "Allow group ${module.cis_security_admins.group_name} to use vnics in compartment ${local.network_compartment_name}",
                          "Allow group ${module.cis_security_admins.group_name} to manage tag-namespaces in tenancy",
                          "Allow group ${module.cis_security_admins.group_name} to manage tag-defaults in tenancy",
                          "Allow group ${module.cis_security_admins.group_name} to manage cloud-guard-family in tenancy",
                          "Allow group ${module.cis_security_admins.group_name} to read audit-events in tenancy",
                          "Allow group ${module.cis_security_admins.group_name} to read tenancies in tenancy",
                          "Allow group ${module.cis_security_admins.group_name} to read objectstorage-namespaces in tenancy",
                          "Allow group ${module.cis_security_admins.group_name} to read app-catalog-listing in tenancy",
                          "Allow group ${module.cis_security_admins.group_name} to read instance-images in tenancy",
                          "Allow group ${module.cis_security_admins.group_name} to inspect buckets in tenancy",
                          "Allow group ${module.cis_security_admins.group_name} to manage orm-stacks in compartment ${local.security_compartment_name}",
                          "Allow group ${module.cis_security_admins.group_name} to manage orm-jobs in compartment ${local.security_compartment_name}",
                          "Allow group ${module.cis_security_admins.group_name} to manage orm-config-source-providers in compartment ${local.security_compartment_name}",
                          "Allow group ${module.cis_security_admins.group_name} to manage vss-family in compartment ${local.security_compartment_name}"]
    }
  }
}

################################################################################


################################################################################
########################### Database Service Artifacts #########################

### Database service - group for managing DBaaS and Autonomous Database.
module "cis_database_admins" {
  source                = "../modules/iam/iam-group"
  providers             = { oci = oci.home }
  tenancy_ocid          = var.tenancy_ocid
  group_name            = local.database_admin_group_name
  group_description     = "Group responsible for managing databases in compartment ${local.database_compartment_name}."
  user_names            = []
  }

### Database service policy
module "cis_database_admins_policy" {
  source                = "../modules/iam/iam-policy"
  providers             = { oci = oci.home }
  depends_on            = [module.cis_database_admins, module.cis_compartments] ### Explicitly declaring dependencies on the group and compartments modules.
  policies              = {
    ("${var.service_label}-DatabaseAdmins-Policy") = {
      compartment_id         = var.tenancy_ocid
      description            = "Policy allowing ${var.service_label}-DatabaseAdmins group to manage database-family in compartment ${module.cis_compartments.compartments[local.database_compartment_name].name}."
      statements             = ["Allow group ${module.cis_database_admins.group_name} to read all-resources in compartment ${local.database_compartment_name}",
                          "Allow group ${module.cis_database_admins.group_name} to manage database-family in compartment ${local.database_compartment_name}",
                          "Allow group ${module.cis_database_admins.group_name} to manage autonomous-database-family in compartment ${local.database_compartment_name}",
                          "Allow group ${module.cis_database_admins.group_name} to manage alarms in compartment ${local.database_compartment_name}",
                          "Allow group ${module.cis_database_admins.group_name} to manage metrics in compartment ${local.database_compartment_name}",
                          "Allow group ${module.cis_database_admins.group_name} to manage object-family in compartment ${local.database_compartment_name}",
                          "Allow group ${module.cis_database_admins.group_name} to use vnics in compartment ${local.database_compartment_name}",
                          "Allow group ${module.cis_database_admins.group_name} to use subnets in compartment ${local.database_compartment_name}",
                          "Allow group ${module.cis_database_admins.group_name} to use network-security-groups in compartment ${local.database_compartment_name}",
                          "Allow group ${module.cis_database_admins.group_name} to read virtual-network-family in compartment ${local.network_compartment_name}",
                          "Allow group ${module.cis_database_admins.group_name} to use vnics in compartment ${local.network_compartment_name}",
                          "Allow group ${module.cis_database_admins.group_name} to use subnets in compartment ${local.network_compartment_name}",
                          "Allow group ${module.cis_database_admins.group_name} to use network-security-groups in compartment ${local.network_compartment_name}",
                          "Allow group ${module.cis_database_admins.group_name} to manage orm-stacks in compartment ${local.database_compartment_name}",
                          "Allow group ${module.cis_database_admins.group_name} to manage orm-jobs in compartment ${local.database_compartment_name}",
                          "Allow group ${module.cis_database_admins.group_name} to manage orm-config-source-providers in compartment ${local.database_compartment_name}",
                          "Allow Group ${module.cis_database_admins.group_name} to read audit-events in compartment ${local.database_compartment_name}",
                          "Allow Group ${module.cis_database_admins.group_name} to read vss-family in compartment ${local.security_compartment_name}"]
    }
  }
}

################################################################################


################################################################################
###################### App. Dev. Service Artifacts #############################

### Application Development services - Combined AppDev with Compute and storage
module "cis_appdev_admins" {
  source                = "../modules/iam/iam-group"
  providers             = { oci = oci.home }
  tenancy_ocid          = var.tenancy_ocid
  group_name            = local.appdev_admin_group_name
  group_description     = "Group responsible for managing app development related services in compartment ${local.appdev_compartment_name}."
  user_names            = []
  }

###  Application development services policy
module "cis_appdev_admins_policy" {
  source                = "../modules/iam/iam-policy"
  providers             = { oci = oci.home }
  depends_on            = [module.cis_appdev_admins, module.cis_compartments] ### Explicitly declaring dependencies on the group and compartments modules.
  policies              = {
    ("${var.service_label}-AppDevAdmins-Policy") = {
      compartment_id         = var.tenancy_ocid
      description            = "Policy allowing ${var.service_label}-AppDevAdmins group to manage app development related services in compartment ${module.cis_compartments.compartments[local.appdev_compartment_name].name}."
      statements             = ["Allow group ${module.cis_appdev_admins.group_name} to read all-resources in compartment ${local.appdev_compartment_name}",
                          "Allow group ${module.cis_appdev_admins.group_name} to manage functions-family in compartment ${local.appdev_compartment_name}",
                          "Allow group ${module.cis_appdev_admins.group_name} to manage api-gateway-family in compartment ${local.appdev_compartment_name}",
                          "Allow group ${module.cis_appdev_admins.group_name} to manage ons-family in compartment ${local.appdev_compartment_name}",
                          "Allow group ${module.cis_appdev_admins.group_name} to manage streams in compartment ${local.appdev_compartment_name}",
                          "Allow group ${module.cis_appdev_admins.group_name} to manage cluster-family in compartment ${local.appdev_compartment_name}",
                          "Allow group ${module.cis_appdev_admins.group_name} to manage alarms in compartment ${local.appdev_compartment_name}",
                          "Allow group ${module.cis_appdev_admins.group_name} to manage metrics in compartment ${local.appdev_compartment_name}",
                          "Allow group ${module.cis_appdev_admins.group_name} to manage logs in compartment ${local.appdev_compartment_name}",
                          "Allow group ${module.cis_appdev_admins.group_name} to manage instance-family in compartment ${local.appdev_compartment_name}",
                          "Allow group ${module.cis_appdev_admins.group_name} to manage volume-family in compartment ${local.appdev_compartment_name}",
                          "Allow group ${module.cis_appdev_admins.group_name} to manage object-family in compartment ${local.appdev_compartment_name}",
                          "Allow group ${module.cis_appdev_admins.group_name} to read virtual-network-family in compartment ${local.network_compartment_name}",
                          "Allow group ${module.cis_appdev_admins.group_name} to use subnets in compartment ${local.network_compartment_name}",
                          "Allow group ${module.cis_appdev_admins.group_name} to use network-security-groups in compartment ${local.network_compartment_name}",
                          "Allow group ${module.cis_appdev_admins.group_name} to use vnics in compartment ${local.network_compartment_name}",
                          "Allow group ${module.cis_appdev_admins.group_name} to use load-balancers in compartment ${local.network_compartment_name}",
                          "Allow group ${module.cis_appdev_admins.group_name} to read autonomous-database-family in compartment ${local.database_compartment_name}",
                          "Allow group ${module.cis_appdev_admins.group_name} to read database-family in compartment ${local.database_compartment_name}",
                          "Allow group ${module.cis_appdev_admins.group_name} to read vaults in compartment ${local.security_compartment_name}",
                          "Allow group ${module.cis_appdev_admins.group_name} to inspect keys in compartment ${local.security_compartment_name}",
                          "Allow group ${module.cis_appdev_admins.group_name} to read app-catalog-listing in tenancy",
                          "Allow group ${module.cis_appdev_admins.group_name} to read instance-images in tenancy",
                          "Allow group ${module.cis_appdev_admins.group_name} to manage repos in tenancy",
                          "Allow group ${module.cis_appdev_admins.group_name} to manage orm-stacks in compartment ${local.appdev_compartment_name}",
                          "Allow group ${module.cis_appdev_admins.group_name} to manage orm-jobs in compartment ${local.appdev_compartment_name}",
                          "Allow group ${module.cis_appdev_admins.group_name} to manage orm-config-source-providers in compartment ${local.appdev_compartment_name}",
                          "Allow Group ${module.cis_appdev_admins.group_name} to read audit-events in compartment ${local.appdev_compartment_name}",
                          "Allow Group ${module.cis_appdev_admins.group_name} to read vss-family in compartment ${local.security_compartment_name}"]
    }
  }
}

################################################################################


################################################################################
########################### Audit Artifacts ####################################

### Auditors
module "cis_tenancy_auditors" {
  source                = "../modules/iam/iam-group"
  providers             = { oci = oci.home }
  tenancy_ocid          = var.tenancy_ocid
  group_name            = local.auditor_group_name
  group_description     = "Group responsible for Auditing the tenancy"
  user_names            = []
  }

### Auditors policy
module "cis_tenancy_auditors_policy" {
  source                = "../modules/iam/iam-policy"
  providers             = { oci = oci.home }
  depends_on            = [module.cis_tenancy_auditors] ### Explicitly declaring dependency on the group module.
  policies              = {
    ("${var.service_label}-AuditorAccess-Policy") = {
      compartment_id         = var.tenancy_ocid
      description            = "Policy allowing ${module.cis_tenancy_auditors.group_name} group to audit tenancy."
      statements             = ["Allow group ${module.cis_tenancy_auditors.group_name} to inspect all-resources in tenancy",
                          "Allow group ${module.cis_tenancy_auditors.group_name} to read instances in tenancy",
                          "Allow group ${module.cis_tenancy_auditors.group_name} to read load-balancers in tenancy",
                          "Allow group ${module.cis_tenancy_auditors.group_name} to read buckets in tenancy",
                          "Allow group ${module.cis_tenancy_auditors.group_name} to read nat-gateways in tenancy",
                          "Allow group ${module.cis_tenancy_auditors.group_name} to read public-ips in tenancy",
                          "Allow group ${module.cis_tenancy_auditors.group_name} to read file-family in tenancy",
                          "Allow group ${module.cis_tenancy_auditors.group_name} to read instance-configurations in tenancy",
                          "Allow Group ${module.cis_tenancy_auditors.group_name} to read network-security-groups in tenancy",
                          "Allow Group ${module.cis_tenancy_auditors.group_name} to read resource-availability in tenancy",
                          "Allow Group ${module.cis_tenancy_auditors.group_name} to read audit-events in tenancy",
                          "Allow Group ${module.cis_tenancy_auditors.group_name} to use cloud-shell in tenancy",
                          "Allow Group ${module.cis_tenancy_auditors.group_name} to read vss-family in tenancy"]
    }
  }
}

################################################################################


################################################################################
######################## Announcement Artifacts #################################

### Announcement Readers group
module "cis_tenancy_announcement_readers" {
  source                = "../modules/iam/iam-group"
  providers             = { oci = oci.home }
  tenancy_ocid          = var.tenancy_ocid
  group_name            = local.announcement_readers_group_name
  group_description     = "Group responsible for Console Announcements"
  user_names            = []
  }

### Announcement Readers policy
module "cis_tenancy_announcement_readers_policy" {
  source                = "../modules/iam/iam-policy"
  providers             = { oci = oci.home }
  depends_on            = [module.cis_tenancy_announcement_readers] ### Explicitly declaring dependency on the group module.
  policies              = {
    ("${var.service_label}-AnnouncementReaders-Policy") = {
      compartment_id         = var.tenancy_ocid
      description            = "Policy allowing ${module.cis_tenancy_announcement_readers.group_name} group to audit tenancy."
      statements             = ["Allow group ${module.cis_tenancy_announcement_readers.group_name} to read announcements in tenancy"]
    }
  }
}

################################################################################