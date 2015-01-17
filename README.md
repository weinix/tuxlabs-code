Various Things
=================

Tools used for deploying and maintaining openstack clouds. 

###Openstack-Scripts

###### openstack-configs/ 
	Copy of my blessed configs for my working install of CentOS 6.5 / Icehouse All-In-One using packstack. 
###### save-os-configs.sh 
	Copies the contents of all pertinent openstack config & ini files into openstack-configs/
###### uninstall_packstack.sh 
	Script to uninstall packstack, since one does not come with it.

###Runner

###### runner.py
	Multi-threaded SSH command runner with sudo support
###### update-runner-hosts.pl
	A perl script that grabs hosts from a URL and populates a hosts directory and required hosts file for runner.py
