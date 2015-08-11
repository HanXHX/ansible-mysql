About tests
===========

IMPORTANT
---------

- DO NOT `vagrant up`! My Vagrantfile provides 14 VMs (256MB each)...
- Each slave communicate to his master. You can't mix jessie and wheezy or mysql and mariadb.
- This tests uses my [MySQL role](https://github.com/HanXHX/ansible-mysql).


Tests
-----

- vagrant up the master
- vagrant up the slave

Wait master fully installed before run slave.

Example:

```
sudo ansible-galaxy install HanXHX.mysql
vagrant up jessie-upstream-mariadb-master
vagrant up jessie-upstream-mariadb-slave
```

Supported platforms
-------------------

- Debian Wheezy
- Debian Jessie

Supported MySQL vendors
-----------------------

- MariaDB 10.0 (from Debian Jessie or MariaDB repository)
- MySQL 5.5 (from Debian repositories)
- Percona Server 5.6 (from Percona Repository)

About MySQL 5.6
---------------

You can get MySQL 5.6 for Debian with [Dotdeb](https://www.dotdeb.org) with my [Dotdeb role](https://github.com/HanXHX/ansible-debian-dotdeb). I give no support with this version (pull-request accepted). It can work but without GTID.

About MariaDB 10.1
------------------

When the application is considered stable, I'll support this version.
