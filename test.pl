###
# Copyright 1998, 1999 Massachusetts Institute of Technology
#
# Permission to use, copy, modify, distribute, and sell this software and its
# documentation for any purpose is hereby granted without fee, provided that
# the above copyright notice appear in all copies and that both that
# copyright notice and this permission notice appear in supporting
# documentation, and that the name of M.I.T. not be used in advertising or
# publicity pertaining to distribution of the software without specific,
# written prior permission.  M.I.T. makes no representations about the
# suitability of this software for any purpose.  It is provided "as is"
# without express or implied warranty.

###
# File:		test.pl
# Author:	Daniel Hagerty, hag@ai.mit.edu
# Date:		Sat Oct 17 22:33:40 1998
# Description:	test stuff for Tree::Radix
#
# $Id: test.pl,v 1.4 2000/11/17 22:45:16 hag Exp $

# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

######################### We start with some black magic to print on failure.

# Turn on warnings.
$^W = 1;

# Change 1..1 below to 1..last_test_to_print .
# (It may become useful if the test is moved to ./t subdirectory.)

BEGIN { $| = 1; print "1..3\n"; }
END {print "not ok 1\n" unless $loaded;}
use Net::Traceroute;
$loaded = 1;

print "ok 1\n";

######################### End of black magic.

# Test 2: Create an empty object

my $tr = new Net::Traceroute() || do { print "not ok 2\n" ; exit 1};
print "ok 2\n";

# Test 3: traceroute to self.  localhost doesn't work on some OSes.

my $uname = `uname -n`;		# XXX Sys::Hostname ?
chomp $uname;

my $tr_suceed = &test_tr($uname);

# Didn't work at all
if(!defined($tr_suceed)) {
    print "not ok 3\n";
}

if($tr_suceed != 0) {
    print "ok 3\n";
} else {
    # Some OSes don't allow traceroute to localhost.  Ask the user
    # for a host and do it again
    {
	local $| = 1;

	print "Traceroute to $uname didn't work.\n";
	print "Please name a host that you can traceroute: ";

	my $testhost = <STDIN>;
	chomp $testhost;

	my $test_tr = &test_tr($testhost);
	if(!$test_tr) {
	    print "not ok 3\n";
	} else {
	    print "ok 3\n";
	}
    }
}

sub test_tr {
    my $hostname = shift;

    my $self_tr = $tr->new(host => $hostname, timeout=>30,
#			   debug => 9,
			   );

    return() if(!$self_tr);

    if($self_tr->stat != TRACEROUTE_OK || ! $self_tr->found) {
	return 0;
    }
    return 1;
}
