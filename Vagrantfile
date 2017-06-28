# -*- mode: ruby -*-
# vi: set ft=ruby :
# vi: set tabstop=2 :
# vi: set shiftwidth=2 :

Vagrant.configure("2") do |config|

  vbox_deb_jessie = 'debian/jessie64'
  vbox_deb_stretch = 'debian/stretch64'
  dk_deb_jessie = 'hanxhx/vagrant-ansible:debian8'
  dk_deb_stretch = 'hanxhx/vagrant-ansible:debian9'

  config.hostmanager.enabled = true
  config.hostmanager.manage_host = false
  config.hostmanager.manage_guest = true
  config.hostmanager.ignore_private_ip = false
  config.hostmanager.include_offline = false

  cases = [
    # Debian Jessie
    { os_name: 'jessie',  vbox: vbox_deb_jessie,  docker: dk_deb_jessie,  vars: {mysql_origin: 'default',  mysql_vendor: 'mysql'   }, groups: ['master'] },
    { os_name: 'jessie',  vbox: vbox_deb_jessie,  docker: nil,            vars: {mysql_origin: 'default',  mysql_vendor: 'mysql'   }, groups: ['slave'] },
    { os_name: 'jessie',  vbox: vbox_deb_jessie,  docker: dk_deb_jessie,  vars: {mysql_origin: 'default',  mysql_vendor: 'mariadb' }, groups: ['master'] },
    { os_name: 'jessie',  vbox: vbox_deb_jessie,  docker: nil,            vars: {mysql_origin: 'default',  mysql_vendor: 'mariadb' }, groups: ['slave'] },
    { os_name: 'jessie',  vbox: vbox_deb_jessie,  docker: dk_deb_jessie,  vars: {mysql_origin: 'upstream', mysql_vendor: 'mariadb' }, groups: ['master'] },
    { os_name: 'jessie',  vbox: vbox_deb_jessie,  docker: nil,            vars: {mysql_origin: 'upstream', mysql_vendor: 'mariadb' }, groups: ['slave'] },
    { os_name: 'jessie',  vbox: vbox_deb_jessie,  docker: dk_deb_jessie,  vars: {mysql_origin: 'upstream', mysql_vendor: 'percona' }, groups: ['master'] },
    { os_name: 'jessie',  vbox: vbox_deb_jessie,  docker: nil,            vars: {mysql_origin: 'upstream', mysql_vendor: 'percona' }, groups: ['slave'] },
    { os_name: 'jessie',  vbox: vbox_deb_jessie,  docker: dk_deb_jessie,  vars: {mysql_origin: 'upstream' },                          groups: ['mariadbgalera', '1'] },
    { os_name: 'jessie',  vbox: vbox_deb_jessie,  docker: nil,            vars: {mysql_origin: 'upstream' },                          groups: ['mariadbgalera', '2'] },
    { os_name: 'jessie',  vbox: vbox_deb_jessie,  docker: nil,            vars: {mysql_origin: 'upstream' },                          groups: ['mariadbgalera', '3'] },
    # Debian Stretch
    { os_name: 'stretch', vbox: vbox_deb_stretch, docker: dk_deb_stretch, vars: {mysql_origin: 'default',  mysql_vendor: 'mysql'   }, groups: ['master'] },
    { os_name: 'stretch', vbox: vbox_deb_stretch, docker: nil,            vars: {mysql_origin: 'default',  mysql_vendor: 'mysql'   }, groups: ['slave'] },
    { os_name: 'stretch', vbox: vbox_deb_stretch, docker: dk_deb_stretch, vars: {mysql_origin: 'default',  mysql_vendor: 'mariadb' }, groups: ['master'] },
    { os_name: 'stretch', vbox: vbox_deb_stretch, docker: nil,            vars: {mysql_origin: 'default',  mysql_vendor: 'mariadb' }, groups: ['slave'] },
    { os_name: 'stretch', vbox: vbox_deb_stretch, docker: dk_deb_stretch, vars: {mysql_origin: 'upstream', mysql_vendor: 'mariadb' }, groups: ['master'] },
    { os_name: 'stretch', vbox: vbox_deb_stretch, docker: nil,            vars: {mysql_origin: 'upstream', mysql_vendor: 'mariadb' }, groups: ['slave'] },
#   { os_name: 'stretch', vbox: vbox_deb_stretch, docker: dk_deb_stretch, vars: {mysql_origin: 'upstream', mysql_vendor: 'percona' }, groups: ['master'] },
#   { os_name: 'stretch', vbox: vbox_deb_stretch, docker: nil,            vars: {mysql_origin: 'upstream', mysql_vendor: 'percona' }, groups: ['slave'] },
    { os_name: 'stretch', vbox: vbox_deb_stretch, docker: dk_deb_stretch, vars: {mysql_origin: 'upstream' },                          groups: ['mariadbgalera', '1'] },
    { os_name: 'stretch', vbox: vbox_deb_stretch, docker: nil,            vars: {mysql_origin: 'upstream' },                          groups: ['mariadbgalera', '2'] },
    { os_name: 'stretch', vbox: vbox_deb_stretch, docker: nil,            vars: {mysql_origin: 'upstream' },                          groups: ['mariadbgalera', '3'] },
  ]

  cases.each_with_index do |opts,index|
    name = 'docker-' + opts[:os_name] + '-' + opts[:vars].map{|k,v| "#{v}"}.join('-') + '-' +  opts[:groups].join('-')
    iplsb = 10 + index
    ip = '192.168.201.' + iplsb.to_s
    next if opts[:docker].nil?

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
        ansible.sudo = true
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
        ansible.sudo = true
        ansible.extra_vars = opts[:vars].merge({ is_docker: false })
        ansible.groups = { opts[:groups][0] => name }
      end
    end
  end
end
