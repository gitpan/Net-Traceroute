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
# $Id: test.pl,v 1.1 1999/03/05 20:04:27 hag Exp $

# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

######################### We start with some black magic to print on failure.

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

# Test 3: traceroute to localhost
my $self_tr = $tr->new(host => "localhost") ||
    do { print "not ok 3\n" ; exit 1};

if($self_tr->stat != TRACEROUTE_OK || $self_tr->hops != 1) {
    print "not ok 3\n";
    exit 1;
}

print "ok 3\n";
