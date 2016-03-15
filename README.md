MySQL vendors for Debian Ansible role
======================================

[![Ansible Galaxy](http://img.shields.io/badge/ansible--galaxy-HanXHX.mysql-blue.svg)](https://galaxy.ansible.com/HanXHX/mysql)

Install and configure MySQL or MariaDB or Percona Server. Manage replication (master/slave). Create users and databases.

Requirements
------------

None.

Role Variables
--------------

- `mysql_origin`: origin of the package ("default" or "upstream")
- `mysql_vendor`: "mysql", "mariadb" or "percona"
- `mysql_use_percona_repository`: use percona APT repository (automatic setted to true if you use "percona" as `mysql_vendor`). You need to set "true" on Wheezy if you want to install percona-xtrabackup.

### Configuration

- `mysql_root_password`: root password (should be protected with [vault](http://docs.ansible.com/playbooks_vault.html))

If you need a feature you can't configure, you can use this list. These config will go to `/etc/mysql/conf.d/01-extra`.

- `mysql_extra_config`: key/value hash see [default vars file](defaults/main.yml)

### Databases

- `mysql_databases`: list...


### Users

Example:

```
mysql_users:
  - name: 'kiki'
    password: '123'
    priv: hihi.*:ALL
    host: '%'
```

Check "priv" syntax in [mysql_user module documentation](http://docs.ansible.com/mysql_user_module.html)

### Packaging

- `mariadb_version`: 5.5 (Debian Wheezy only) or 10.0
- `mariadb_repository`: MariaDB upstream APT repository (see: [MariaDB repositories tool](http://mariadb.org/mariadb/repositories/))
- `percona_version`: Percona version 5.5 or 5.6
- `percona_repository`: Percona upstream APT repository (see: [Percona APT doc](http://www.percona.com/doc/percona-server/5.5/installation/apt_repo.html))

Dependencies
------------

None.

Example Playbook
----------------

    - hosts: servers
      roles:
         - { role: HanXHX.mysql, mysql_origin: 'upstream', mysql_vendor: 'mariadb' }

License
-------

GPLv2

Author Information
------------------

- You can find many other roles in my GitHub "lab": https://github.com/HanXHX/my-ansible-playbooks
- All issues, pull-request are welcome :)
- Few code come from [geerlingguy](https://github.com/geerlingguy)

