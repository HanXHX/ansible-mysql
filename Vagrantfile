# -*- mode: ruby -*-
# vi: set ft=ruby :
# vi: set tabstop=2 :
# vi: set shiftwidth=2 :

Vagrant.configure("2") do |config|

  vbox_deb_buster = 'debian/buster64'
  dk_deb_buster = 'hanxhx/vagrant-ansible:debian10'

  config.hostmanager.enabled = true
  config.hostmanager.manage_host = false
  config.hostmanager.manage_guest = true
  config.hostmanager.ignore_private_ip = false
  config.hostmanager.include_offline = false

  cases = [
    # ========================
    # Debian Buster
    # ========================

    # Default replication
    { os_name: 'buster', vbox: vbox_deb_buster, docker: dk_deb_buster, vars: {mariadb_origin: 'default'  }, groups: ['master'] },
    { os_name: 'buster', vbox: vbox_deb_buster, docker: nil,           vars: {mariadb_origin: 'default'  }, groups: ['slave'] },

    # Upstream replication
    { os_name: 'buster', vbox: vbox_deb_buster, docker: dk_deb_buster, vars: {mariadb_origin: 'upstream' }, groups: ['master'] },
    { os_name: 'buster', vbox: vbox_deb_buster, docker: nil,           vars: {mariadb_origin: 'upstream' }, groups: ['slave'] },

    # Galera Debian
    { os_name: 'buster', vbox: vbox_deb_buster, docker: dk_deb_buster, vars: {mariadb_origin: 'default'  }, groups: ['galera', '1'] },
    { os_name: 'buster', vbox: vbox_deb_buster, docker: nil,           vars: {mariadb_origin: 'default'  }, groups: ['galera', '2'] },
    { os_name: 'buster', vbox: vbox_deb_buster, docker: nil,           vars: {mariadb_origin: 'default'  }, groups: ['galera', '3'] },

    # Galera Upstream
    { os_name: 'buster', vbox: vbox_deb_buster, docker: dk_deb_buster, vars: {mariadb_origin: 'upstream' }, groups: ['galera', '1'] },
    { os_name: 'buster', vbox: vbox_deb_buster, docker: nil,           vars: {mariadb_origin: 'upstream' }, groups: ['galera', '2'] },
    { os_name: 'buster', vbox: vbox_deb_buster, docker: nil,           vars: {mariadb_origin: 'upstream' }, groups: ['galera', '3'] },
  ]

  cases.each_with_index do |opts,index|
    name = 'docker-' + opts[:os_name] + '-' + opts[:vars].map{|k,v| "#{v}"}.join('-') + '-' +  opts[:groups].join('-')
    iplsb = 10 + index
    ip = '192.168.201.' + iplsb.to_s
    next if opts[:docker].nil?

    config.vm.synced_folder ".", "/vagrant", disabled: true
    config.vm.define name do |m|
      m.vm.network "private_network", ip: ip
      m.vm.provider "docker" do |d|
        d.image = opts[:docker]
        d.remains_running = true
        d.has_ssh = true
      end
      m.vm.provision "ansible" do |ansible|
        ansible.playbook = "tests/test.yml"
        ansible.verbose = 'vv'
        ansible.become = true
        ansible.extra_vars = opts[:vars].merge({ is_docker: true })
        ansible.groups = { opts[:groups][0] => name }
      end
    end
  end

  cases.each_with_index do |opts,index|
    name = 'vbox-' + opts[:os_name] + '-' + opts[:vars].map{|k,v| "#{v}"}.join('-') + '-' +  opts[:groups].join('-')
    iplsb = 10 + index
    ip = '192.168.200.' + iplsb.to_s
    config.vm.define name do |m|
      m.vm.hostname = name
      m.vm.box = opts[:vbox]
      m.vm.network "private_network", ip: ip
      m.vm.provider "virtualbox" do |v|
        v.cpus = 1
        v.memory = 256
      end
      m.vm.provision "ansible" do |ansible|
        ansible.playbook = "tests/test.yml"
        ansible.verbose = 'vv'
        ansible.become = true
        ansible.extra_vars = opts[:vars].merge({ is_docker: false })
        ansible.groups = { opts[:groups][0] => name }
      end
    end
  end
end
