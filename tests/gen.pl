#!/usr/bin/perl

#
# This script generates ansible test config for Vagrant
#

use strict;
use warnings;
use Socket;

my @a = (
    "jessie-default-mysql-master",
    "jessie-default-mysql-slave",
    "jessie-upstream-mariadb-master",
    "jessie-upstream-mariadb-slave",
    "jessie-upstream-percona-master",
    "jessie-upstream-percona-slave",
    "jessie-default-mariadb-master",
    "jessie-default-mariadb-slave",
    "jessie-upstream-mariadbgalera-1",
    "jessie-upstream-mariadbgalera-2",
    "jessie-upstream-mariadbgalera-3"
);

my $start_ip = '192.168.200.10';
my $iip = ip2long($start_ip);
my $tmp_ip = 0;

foreach my $n (@a)
{
	my @data = split(/-/, $n);
	printf(
		'["%s", "debian/%s64", "%s", [%s]],' . "\n",
		$n,
		$data[0],
		long2ip($iip),
		join(',', map { sprintf('"%s"', $_) } @data)
	);

	if($data[-1] eq 'slave')
	{
		open(FILE, '>', "host_vars/$n");
		printf FILE (qq/his_master: '%s'\n/, $tmp_ip);
		close(FILE);
	}

	if($data[-1] =~ /^\d$/ && $data[-2] eq 'mariadbgalera')
	{
		open(FILE, '>', "host_vars/$n");
		printf FILE (qq/galera_id: '%s'\n/, $data[-1]);
		close(FILE);
	}

	open(FILE, '>', "group_vars/" . $data[2]);
	my $mv = $data[-2];
	$mv = 'mariadb_galera' if($mv eq 'mariadbgalera');
	printf FILE (qq/mysql_vendor: '%s'\n/, $mv);
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
