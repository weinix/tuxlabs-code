#!/bin/bash 
#Author: Jason Riedel
#Date: August 4th, 2014
#Description: Snapshot / Save existing openstack config files removing unnecessary garbage. The result are a set of blessed configs helpful for troubleshooting and future bootstrapping of an openstack cloud.  
#Omitted: Horizon configuration, Heat, anything not under /etc/$openstack-service/ add to misclist anything missing. 

## Setup our variables ##
dir="openstack-configs/"
allconfigs="all-configs.txt"

## Create the directory to store the blessed configs in. ##
if [ -d "$dir" ];
then
	echo "$dir exists."
else
	mkdir -p "$dir" 
	echo "Info: $dir does not exist and was created."
fi

## Delete all-configs.txt if it already exists ##
acpath="$dir$allconfigs"
if [ -e "$acpath" ];
then
        echo "removing $acpath"
        rm -f "$acpath"
fi

## List of openstack files by service, augment as necessary. ##
keystonelist=(/etc/keystone/keystone.conf) 
novalist=(/etc/nova/nova.conf) 
neutronlist=(/etc/neutron/dhcp_agent.ini /etc/neutron/fwaas_driver.ini /etc/neutron/l3_agent.ini /etc/neutron/lbaas_agent.ini /etc/neutron/metadata_agent.ini /etc/neutron/neutron.conf /etc/neutron/plugins/ml2/ml2_conf.ini /etc/neutron/plugins/openvswitch/ovs_neutron_plugin.ini)
glancelist=(/etc/glance/glance-api.conf  /etc/glance/glance-cache.conf  /etc/glance/glance-registry.conf  /etc/glance/glance-scrubber.conf /etc/glance/glance-api-paste.ini  /etc/glance/glance-registry-paste.ini ) 
swiftlist=(/etc/swift/account-server.conf  /etc/swift/container-server.conf  /etc/swift/object-expirer.conf  /etc/swift/object-server.conf  /etc/swift/proxy-server.conf  /etc/swift/swift.conf )
cinderlist=(/etc/cinder/cinder.conf)
ceilometerlist=(/etc/ceilometer/ceilometer.conf)
misclist=(/etc/sysconfig/iptables /etc/selinux/config /etc/resolv.conf /etc/hosts /etc/sysconfig/network-scripts/ifcfg-eth0 /etc/sysconfig/network-scripts/ifcfg-eth1 /etc/sysconfig/network-scripts/ifcfg-br-ex /etc/sysconfig/network-scripts/ifcfg-br-int /etc/dnsmasq.conf) 


## Loop through the files and save the configs ## 
for configs in ${keystonelist[*]} ${novalist[*]} ${neutronlist[*]} ${glancelist[*]} ${swiftlist[*]} ${cinderlist[*]} ${ceilometerlist[*]} ${misclist[*]}
do
	for files in $configs
	do
		for file in $files
		do 
			# saving the config of each file 
			filename=$(echo $file | awk -F '/' '{print $NF}')
			fullpath=$dir$filename
			cat $file | grep -v ^$ | grep -v ^# > $fullpath.`date +%Y%m%d`

			# saving all-configs.txt
			echo " ======= $file =======" >> $acpath
			cat $file | grep -v ^$ | grep -v ^# >> $acpath
			echo "" >> $acpath
			echo "" >> $acpath

			echo "$file saved to $fullpath and added to $acpath"
		done
	done
done 

