About tests
===========

IMPORTANT
---------

- DO NOT `vagrant up`! My Vagrantfile provides many VMs...
- Each slave communicate to his master.

Tests
-----

- vagrant up the-master
- vagrant up the-slave

Wait master fully installed before run slave.

Example:

```
vagrant up vbox-buster-default-master
vagrant up vbox-buster-default-slave
```
