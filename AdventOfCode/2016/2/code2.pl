#!/usr/bin/env perl

use strict;
use warnings;

my @char = (0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 'A', 'B', 'C', 'D');
my $curr = 5;
my $pass = "";

my %invalidMoves;
$invalidMoves{U} = {
	1 => 1,
	2 => 1,
	4 => 1,
	5 => 1,
	9 => 1
};
$invalidMoves{L} = {
	1 => 1,
	2 => 1,
	5 => 1,
	10 => 1,
	13 => 1
};
$invalidMoves{D} = {
	5 => 1,
	9 => 1,
	10 => 1,
	12 => 1,
	13 => 1
};
$invalidMoves{R} = {
	1 => 1,
	4 => 1,
	9 => 1,
	12 => 1,
	13 => 1
};

while( my $line = <STDIN> ) {
	if ( length($line) == 0 ) {
		last;
	}
	my @instructions = split(//, $line);
	foreach my $instruction ( @instructions ) {
		if ( not defined $invalidMoves{$instruction}{$curr} ) {
			if($instruction eq 'U') {
				if ( $curr < 5 or $curr > 12 ) {
					$curr -= 2;
				} else {
					$curr -= 4;
				}
			} elsif ( $instruction eq 'L') {
				$curr--;
			} elsif ( $instruction eq 'D') {
				if ( $curr < 2 or $curr > 10 ) {
					$curr += 2;
				} else {
					$curr += 4;
				}
			} elsif ( $instruction eq 'R') {
				$curr++;
			}
		}
	}
	$pass = $pass . "$char[$curr]";
	print $pass;
}
