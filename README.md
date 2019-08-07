MariaDB (MySQL) Ansible role for Debian
=======================================

[![Ansible Galaxy](http://img.shields.io/badge/ansible--galaxy-HanXHX.mysql-blue.svg)](https://galaxy.ansible.com/HanXHX/mysql) [![Build Status](https://travis-ci.org/HanXHX/ansible-mysql.svg?branch=master)](https://travis-ci.org/HanXHX/ansible-mysql)

Install and configure MariaDB (Galera Cluster). Manage replication (master/slave). Create users and databases.

| OS              | Origin    | MariaDB versions          |
| --------------- | --------- | ------------------------- |
| Debian Stretch  | Debian    | 10.1                      |
| Debian Stretch  | Upstream  | 10.1 / 10.2 / 10.3 / 10.4 |
| Debian Buster   | Debian    | 10.3                      |
| Debian Buster   | Upstream  | 10.3 / 10.4               |

Notes
-----

* Galera Cluster is experimental
* Due to Vagrant + Docker limitation (private network), replication/galera can't be checked with Travis
* If you need to test this role with Vagrant, you must install hostmanager plugin: `vagrant plugin install vagrant-hostmanager`
* Percona Xtrabackup is not available in upstream repository. This feature is disabled in the role.

Requirements
------------

Ansible 2.5+

Role Variables
--------------

- `mariadb_use_galera`: set true to configure and install Galera Cluster

### Configuration

- `mariadb_root_password`: root password (should be protected with [vault](http://docs.ansible.com/playbooks_vault.html))

If you need a feature you can't configure, you can use this list. These config will go to `/etc/mysql/conf.d/01-extra`.

- `mariadb_extra_config`: key/value hash see [default vars file](defaults/main.yml)

### Databases

- `mariadb_databases`: list...

### Users

Example:

```
mariadb_users:
  - name: 'lorem'
    password: '123'
    priv: lorem.*:ALL
    host: 'localhost'
  - name: 'ipsum'
    password: '465'
    priv: ipsum.*:ALL
    host_all: yes
```

Check "priv" syntax in [mysql\_user module documentation](http://docs.ansible.com/mysql_user_module.html)

### Packaging

- `mariadb_version`: depends Debian version
- `mariadb_repository`: MariaDB upstream APT repository (see: [MariaDB repositories tool](https://downloads.mariadb.org/mariadb/repositories))
- `mariadb_percona_repository`: Percona upstream APT repository (see: [Percona APT doc](http://www.percona.com/doc/percona-server/5.5/installation/apt_repo.html))
- `mariadb_use_percona_apt`: Force using Percona APT repository (useful when you want to use latest version of percona toolkits, xtrabackup... etc)

Dependencies
------------

None.

Example Playbook
----------------

    - hosts: servers
      roles:
         - { role: HanXHX.mysql, mariadb_origin: 'upstream' }

License
-------

GPLv2

Donation
--------

If this code helped you, or if you’ve used them for your projects, feel free to buy me some :beers:

- Bitcoin: `1BQwhBeszzWbUTyK4aUyq3SRg7rBSHcEQn`
- Ethereum: `0x63abe6b2648fd892816d87a31e3d9d4365a737b5`
- Litecoin: `LeNDw34zQLX84VvhCGADNvHMEgb5QyFXyD`
- Monero: `45wbf7VdQAZS5EWUrPhen7Wo4hy7Pa7c7ZBdaWQSRowtd3CZ5vpVw5nTPphTuqVQrnYZC72FXDYyfP31uJmfSQ6qRXFy3bQ`

No crypto-currency? :star: the project is also a way of saying thank you! :sunglasses:

Author Information
------------------

- Twitter: [@hanxhx_](https://twitter.com/hanxhx_)
