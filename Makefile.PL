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
# File:		Makefile.PL
# Author:	Daniel Hagerty, hag@ai.mit.edu
# Date:		Wed Mar 25 00:22:43 1998
# Time-stamp:	<1999-03-05 14:55:34 hag>
# Description:	perl style Makefile for this frob
#
# $Id: Makefile.PL,v 1.1 1999/03/05 20:04:27 hag Exp $

use ExtUtils::MakeMaker;

WriteMakefile(
	NAME	  => 'Net::Traceroute',
	VERSION_FROM => "Traceroute.pm",

	'dist'    => {COMPRESS => 'gzip -9f',
		      SUFFIX   => '.gz',
		      DIST_DEFAULT => 'all tardist',
		     },
);
