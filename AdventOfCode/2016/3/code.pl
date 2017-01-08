#!/usr/bin/env perl

use strict;
use warnings;

use Data::Dumper;

my $count = 0;

MAIN: while ( 1 ) {
	my $line = <STDIN>;
	($line =~ s/\A\s+|\s+\z//g);
	if ($line eq "") {
		last;
	}
	my @sides = split(/\s+/, $line);
	@sides = sort {$a <=> $b} @sides;
	if( $sides[0] + $sides[1] > $sides[2] ) {
		$count++;
	}
}
print $count."\n";
