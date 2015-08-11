#!/usr/bin/perl

#
# This script generates ansible test config for Vagrant
#

use strict;
use warnings;
use Socket;

my @a = (
    "wheezy-default-mysql-master",
    "wheezy-default-mysql-slave",
    "wheezy-upstream-mariadb-master",
    "wheezy-upstream-mariadb-slave",
    "wheezy-upstream-percona-master",
    "wheezy-upstream-percona-slave",
    "jessie-default-mysql-master",
    "jessie-default-mysql-slave",
    "jessie-upstream-mariadb-master",
    "jessie-upstream-mariadb-slave",
    "jessie-upstream-percona-master",
    "jessie-upstream-percona-slave",
    "jessie-default-mariadb-master",
    "jessie-default-mariadb-slave",
);

my $start_ip = '192.168.200.10';
my $iip = ip2long($start_ip);
my $tmp_ip = 0;

foreach my $n (@a)
{
	my @data = split(/-/, $n);
	printf(
		'["%s", "deb/%s-amd64", "%s", [%s]],' . "\n",
		$n,
		$data[0],
		long2ip($iip),
		join(',', map { sprintf('"%s"', $_) } @data)
	);

	if($data[-1]  eq 'slave')
	{
		open(FILE, '>', "host_vars/$n");
		printf FILE (qq/his_master: '%s'\n/, $tmp_ip);
		close(FILE);
	}

	open(FILE, '>', "group_vars/" . $data[2]);
	printf FILE (qq/mysql_vendor: '%s'\n/, $data[2]);
	close(FILE);

	$tmp_ip = long2ip($iip);
	$iip++;
}

sub ip2long {
	return unpack("l*", pack("l*", unpack("N*", inet_aton(shift))));
}

sub long2ip {
	return inet_ntoa(pack("N*", shift));
}
