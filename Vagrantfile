# -*- mode: ruby -*-
# vi: set ft=ruby :
# vi: set tabstop=2 :
# vi: set shiftwidth=2 :

Vagrant.configure("2") do |config|

  vms = [
    [ "wheezy-debian-mysql", "deb/wheezy-amd64" , "192.168.33.40" ],
    [ "wheezy-upstream-mariadb", "deb/wheezy-amd64" , "192.168.33.42" ],
    [ "wheezy-upstream-percona", "deb/wheezy-amd64" , "192.168.33.43" ],
    [ "jessie-debian-mysql", "deb/jessie-amd64", "192.168.33.50" ],
    [ "jessie-debian-mariadb", "deb/jessie-amd64", "192.168.33.51" ],
    [ "jessie-upstream-mariadb", "deb/jessie-amd64", "192.168.33.52" ],
    [ "jessie-upstream-percona", "deb/jessie-amd64", "192.168.33.53" ]
  ]

  config.vm.provider "virtualbox" do |v|
    v.cpus = 1
    v.memory = 256
  end

  vms.each do |vm|
    config.vm.define vm[0] do |m|
      m.vm.box = vm[1]
      m.vm.network "private_network", ip: vm[2]

      m.vm.provision "ansible" do |ansible|
        ansible.playbook = "tests/test.yml"
        ansible.groups = {
          "debian_mysql" => ["wheezy-debian-mysql", "jessie-debian-mysql"],
          "upstream_mariadb" => ["wheezy-upstream-mariadb", "jessie-upstream-mariadb"],
          "upstream_percona" => ["wheezy-upstream-percona", "jessie-upstream-percona"],
          "debian_mariadb" => ["jessie-debian-mariadb"]
        }
        ansible.verbose = 'vv'
        ansible.sudo = true
      end
    end
  end
end
