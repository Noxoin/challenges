#!/usr/bin/env perl

use strict;
use warnings;

my $curr = 5;
my $pass = "";

while( my $line = <STDIN> ) {
	if ( length($line) == 0 ) {
		last;
	}
	my @instructions = split(//, $line);
	foreach my $instruction ( @instructions ) {
		if($instruction eq 'U') {
			if($curr > 3 ) {
				$curr -= 3;
			}
		} elsif ( $instruction eq 'L') {
			if($curr%3 != 1) {
				$curr--;
			}
		} elsif ( $instruction eq 'D') {
			if($curr < 7 ) {
				$curr += 3;
			}
		} elsif ( $instruction eq 'R') {
			if ($curr%3 != 0) {
				$curr++;
			}
		}
	}
	$pass = $pass . "$curr";
	print $pass;
}
