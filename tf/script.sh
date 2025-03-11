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
tf-recreate-vm(){
        terraform destroy -auto-approve --target=module.squid_proxy_server --target=module.icap_server --target=module.network
        terraform apply -auto-approve
}
list-real-ip (){
        echo "real ip of squid-proxy"
        virsh domifaddr squid-proxy
        echo "real ip of icap-serve"
        virsh domifaddr icap-server
}