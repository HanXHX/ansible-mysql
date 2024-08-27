MariaDB (MySQL) Ansible role for Debian
=======================================

[![Ansible Galaxy](http://img.shields.io/badge/ansible--galaxy-HanXHX.mysql-blue.svg)](https://galaxy.ansible.com/HanXHX/mysql) ![GitHub Workflow Status (master)](https://img.shields.io/github/actions/workflow/status/hanxhx/ansible-mysql/molecule.yml?branch=master)

Install and configure MariaDB (Galera Cluster). Manage replication (master/slave). Create users and databases.

|          OS          | Origin    | MariaDB versions |
|:--------------------:|:----------|:-----------------|
| Debian Bookworm (12) | Debian    | 10.11            |
| Debian Bookworm (12) | Upstream  | From 10.11       |

If you need to manage previous Debian versions, please use the [latest managed version](https://github.com/HanXHX/ansible-mysql/releases/tag/2.2.1).


Notes
-----

* Galera Cluster is experimental. Feel free to test it and report issues.

Requirements
------------

- Ansible - see [meta/main.yml](meta/main.yml)
- Collections: see [requirements.yml](requirements.yml)

Role Variables
--------------

- `mariadb_use_galera`: set true to configure and install Galera Cluster

### Configuration

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

Check "priv" syntax in [mysql\_user module documentation](https://docs.ansible.com/ansible/latest/collections/community/mysql/mysql_user_module.html)

### Packaging

- `mariadb_upstream_version`: depends Debian version

### Other

- `mariadb_debug_role`: boolean, set true to disable `no_log` hidding

Dependencies
------------

None.

If you need to dev this role locally with molecule
--------------------------------------------------

Check available scenarios in [molecule](molecule) directory.

With `debian12_master_slave` scenario:

```commandline
molecule -v -c molecule/_shared/base.yml verify -s debian12_master_slave
```

Example Playbook
----------------

    - hosts: servers
      roles:
         - { role: hanxhx.mysql, mariadb_origin: 'upstream' }

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
