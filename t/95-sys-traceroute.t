#!/usr/bin/perl

# Attempt some traceroutes using the system traceroute.  They aren't
# all guaranteed to work, since OS issues, parsability of traceroute,
# and network configuration all interact with this test, and we
# frequently can't predict the issues.

use strict;
use warnings;

use Test::More;

use Net::Traceroute;
use Socket;
use Sys::Hostname;

require "t/testlib.pl";

os_must_unixexec();
plan tests => 2;

####
# Get this sytem's hostname, and traceroute to it.  Don't bother
# trying localhost; its quirky on systems like netbsd.
my $name = hostname();

# Wrinkle: while our specification is that we will use whatever
# traceroute is in path, it's pretty common for testing to be done
# where there is no traceroute in path (especially automated testers).

my $tr1 = eval { Net::Traceroute->new(host => $name, timeout => 30) };

# I haven't figured out how yet, but there are ways the error message
# can be: Cannot exec: No such file or directory
# in some circumstances.  Not chasing it yet..
if($@ && $@ !~ /No output from traceroute.  Exec failure/) {
    die;
} else {
    $ENV{PATH} .= ":/usr/sbin:/sbin";
    $tr1 = Net::Traceroute->new(host => $name, timeout => 30);
}

my $packed_addr = inet_aton($name);
my $addr = inet_ntoa($packed_addr);

is($tr1->hops, 1);
is($tr1->hop_query_host(1, 0), $addr);
