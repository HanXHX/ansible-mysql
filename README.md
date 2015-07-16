MySQL vendors for Debian Ansible role
======================================

Install and configure MySQL or MariaDB or Percona Server. Create users and databases.

IMPORTANT: due to this [bug](https://mariadb.atlassian.net/browse/MDEV-8457), MariaDB don't work on Debian Jessie.

Requirements
------------

None.

Role Variables
--------------

- `mysql_origin`: origin of the package ("default" or "upstream")
- `mysql_vendor`: "mysql", "mariadb" or "percona"

### Configuration

- `mysql_cnf`: key/value hash see [defaults/main.yml](default vars file)
- `mysql_root_password`: root password (should be protected with [vault](http://docs.ansible.com/playbooks_vault.html))

### Databases

- `mysql_databases`: list...


### Users

Example:

```
mysql_users:
  - name: 'kiki'
    password: '123'
    priv: hihi.*:ALL
```

Check "priv" syntax in [http://docs.ansible.com/mysql_user_module.html](mysql_user module documentation)

### Packaging

- `mariadb_version`: 5.5 (Debian Wheezy only) or 10.0
- `mariadb_repository`: MariaDB upstream APT repository (see: [http://mariadb.org/mariadb/repositories/](MariaDB repositories tool))
- `percona_version`: Percona version 5.5 or 5.6
- `percona_repository`: Percona upstream APT repository (see: [http://www.percona.com/doc/percona-server/5.5/installation/apt_repo.html](Percona APT doc))

Dependencies
------------

None.

Example Playbook
----------------

    - hosts: servers
      roles:
         - { role: HanXHX.mysql, mysql_origin: 'mariadb', mysql_vendor: 'mariadb' }

License
-------

GPLv2

Author Information
------------------

- You can find many other roles in my GitHub "lab": https://github.com/HanXHX/my-ansible-playbooks
- All issues, pull-request are welcome :)

