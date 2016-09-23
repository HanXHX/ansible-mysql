# -*- mode: ruby -*-
# vi: set ft=ruby :
# vi: set tabstop=2 :
# vi: set shiftwidth=2 :

Vagrant.configure("2") do |config|

	vms = [
		["jessie-default-mysql-master", "debian/jessie64", "192.168.200.10", ["jessie","default","mysql","master"]],
		["jessie-default-mysql-slave", "debian/jessie64", "192.168.200.11", ["jessie","default","mysql","slave"]],
		["jessie-upstream-mariadb-master", "debian/jessie64", "192.168.200.12", ["jessie","upstream","mariadb","master"]],
		["jessie-upstream-mariadb-slave", "debian/jessie64", "192.168.200.13", ["jessie","upstream","mariadb","slave"]],
		["jessie-upstream-percona-master", "debian/jessie64", "192.168.200.14", ["jessie","upstream","percona","master"]],
		["jessie-upstream-percona-slave", "debian/jessie64", "192.168.200.15", ["jessie","upstream","percona","slave"]],
		["jessie-default-mariadb-master", "debian/jessie64", "192.168.200.16", ["jessie","default","mariadb","master"]],
		["jessie-default-mariadb-slave", "debian/jessie64", "192.168.200.17", ["jessie","default","mariadb","slave"]],
		["jessie-default-mariadb_galera-1", "debian/jessie64", "192.168.200.18", ["jessie","default","mariadb_galera","1"]],
		["jessie-default-mariadb_galera-2", "debian/jessie64", "192.168.200.19", ["jessie","default","mariadb_galera","2"]],
		["jessie-default-mariadb_galera-3", "debian/jessie64", "192.168.200.20", ["jessie","default","mariadb_galera","3"]]
	]

	config.vm.provider "virtualbox" do |v|
		v.cpus = 1
		v.memory = 256
	end

	vms.each do |vm|
		config.vm.define vm[0] do |m|
			m.vm.hostname = vm[0]
			m.vm.box = vm[1]
			m.vm.network "private_network", ip: vm[2]

			m.vm.provision "ansible" do |ansible|
				ansible.playbook = "tests/test.yml"
				ansible.groups = {
					vm[3][0] => vm[0],
					vm[3][1] => vm[0],
					vm[3][2] => vm[0],
					vm[3][3] => vm[0],
				}
				ansible.verbose = 'vv'
				ansible.sudo = true
			end
		end
	end
end
