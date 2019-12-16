About tests
===========

IMPORTANT
---------

- DO NOT `vagrant up`! My Vagrantfile provides many VMs...
- Each slave communicate to his master. You can't mix mysql and mariadb.

Tests
-----

- vagrant up the master
- vagrant up the slave

Wait master fully installed before run slave.

Example:

```
vagrant up buster-upstream-mariadb-master
vagrant up buster-upstream-mariadb-slave
```
