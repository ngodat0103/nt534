#!/bin/bash
shutdown-all-vms() {
        echo "Shutting down all VMs"
        for vm in $(virsh list --name); do
         virsh shutdown "$vm"
        done
        echo "All VMs are shut down"
}
boot-all-vm (){
        terraform apply -auto-approve
}