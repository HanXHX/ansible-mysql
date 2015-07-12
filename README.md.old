MySQL role
==========

Actions
-------

- Install minimal packages
- Install [MariaDB](https://mariadb.org) or [MySQL](http://www.mysql.com) or [Percona Server](http://www.percona.com/software/percona-server)
- Configuration
- Secure your service
- Create databases
- Create users

Variables
---------

- mysql\_vendor: 'mariadb' or 'mysql' or 'percona' (mariadb is default)
- mysql\_root\_password: default password used when installing database service

### Configuration

- mysql\_cnf: key/value hash see [defaults/main.yml](default vars file)

### Databases

- mysql\_databases: list

### Users

Example:

```
mysql\_users:
  - name: 'kiki'
    password: '123'
    priv: hihi.*:ALL
```

Check "priv" syntax in [http://docs.ansible.com/mysql_user_module.html](mysql_user module documentation)


### MariaDB

- mariadb\_version (5.5, 10.0, 10.1)
- mariadb\_repository (see: [http://mariadb.org/mariadb/repositories/](MariaDB repositories tool))

### Percona

- percona\_version (5.5, 5.6)
- percona\_repository (see: [http://www.percona.com/doc/percona-server/5.5/installation/apt_repo.html](Percona APT doc))

Notes
-----

- NEVER (yes NEVER), change your mysql\_vendor or versions! This role don't manage migrations/upgrades/downgrades.
- Be careful! If you use 'mysql' you can have 2 versions: 5.5 (from Debian repository) and 5.6 from [Dotdeb](https://www.dotdeb.org)

TODO
----

- Support Jessie
- Test "official" releases of MySQL [http://dev.mysql.com/doc/mysql-apt-repo-quick-guide/en/](http://dev.mysql.com/doc/mysql-apt-repo-quick-guide/en/)
- Manage Galera and other tools
- Manage replication
- You can secure your password with [http://docs.ansible.com/playbooks_vault.html](Ansible Vault)
