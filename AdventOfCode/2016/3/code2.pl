#!/usr/bin/env perl

use strict;
use warnings;

use Data::Dumper;

my $count = 0;

MAIN: while ( 1 ) {
	my @sets;
	for ( my $i = 0; $i < 3; ++$i ) {
		my $line = <STDIN>;
		($line =~ s/\A\s+|\s+\z//g);
		if ($line eq "") {
			if ($i != 0) {
				print "Last triangle doesn't work\n";
			}
			last MAIN;
		}
		my @sides = split(/\s+/, $line);
		for ( my $j = 0; $j < 3; ++$j ) {
			push @{$sets[$j]}, $sides[$j];
		}
	}

	print Dumper(@sets);

	for ( my $i = 0; $i < 3; ++$i ) {
		my @sides = sort {$a <=> $b} @{$sets[$i]};
		if( $sides[0] + $sides[1] > $sides[2] ) {
			$count++;
		}
	}
}
print $count."\n";
