# terraform vSphere 

provider "vsphere" {
    #(required)
    user = "${var.vsphere_user}"
    password = "${var.vsphere_password}"
    vsphere_server = "${var.vsphere_vcenter}"

    #(optional) allow self signed certs
    allow_unverified_ssl = true

}

data "vsphere_datacenter" "DC0"{
    name = "${var.vsphere_datacenter}"
}

data "vsphere_host" "host0" {
    name = "esxi0"
    datacenter_id = "${data.vsphere_datacenter.DC0.id}"
}

data "vsphere_virtual_machine" "vm_template"{
    name = "testVMtemplate"
    datacenter_id = "${data.vsphere_datacenter.DC0.id}"
}

data "vsphere_datastore" "datastore0"{
    name = "${var.vsphere_datastore}"
    datacenter_id = "${data.vsphere_datacenter.DC0.id}"
}

data "vsphere_compute_cluster" "testcluster0"{
    name = "${var.vsphere_cluster}"
    datacenter_id = "${data.vsphere_datacenter.DC0.id}"
}

data "vsphere_network" "network0" {
    name = "${var.network}"
    datacenter_id = "${data.vsphere_datacenter.DC0.id}"
}

resource "vsphere_resource_pool" "resource_pool0"{
    name = "${var.vsphere_resource_pool}"
    parent_resource_pool_id = "${data.vsphere_compute_cluster.testcluster0.id}"
}