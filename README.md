Tuxlabs-Code
=================

Tools used for deploying and maintaining openstack clouds. 

###Openstack-Scripts

###### openstack-configs/ 
	Copy of my blessed configs for my working install of CentOS 6.5 / Icehouse. 
###### save-os-configs.sh 
	Copies / Stores the contents of all pertinent openstack config & ini files 
###### uninstall_packstack.sh 
	Script to uninstall packstack, since one does not come with it.

###Runner

###### runner.py
	Multi-threaded SSH command runner with sudo support
###### update-runner-hosts.pl
	A perl script that grabs hosts from a URL and populates a hosts directory. 
###### sconnect
	An SSH proxy used to forward SSH connections through a bastion/jump box. 
	See https://bitbucket.org/gotoh/connect/wiki/Home for more info. 
