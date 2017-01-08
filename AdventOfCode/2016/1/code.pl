#!/usr/bin/env perl

use strict;
use warnings;

my ( $nsOffset, $weOffset ) = ( 0, 0 );
my $facing = 10000;
my $in = <STDIN>;
my @instructions = split(", ", $in);

foreach my $instruction ( @instructions ) {
	if ( my ( $direction, $value ) = ( $instruction =~ /^([LR])(\d+)$/) ) {
		if ( $direction eq 'L' ) {
			$facing++;
		} elsif ( $direction eq 'R' ) {
			$facing--;
		} else {
			print("Dafaq is this direction? $direction\n");
		}

		if ( ( $facing % 4 ) == 0 ) {
			$nsOffset += $value;
		} elsif ( ( $facing % 4 ) == 1 ) {
			$weOffset -= $value;
		} elsif ( ( $facing % 4 ) == 2 ) {
			$nsOffset -= $value;
		} elsif ( ( $facing % 4 ) == 3 ) {
			$weOffset += $value;
		} else {
			print("What direction am I facing?!?! $facing\n");
		}

	} else {
		print("Error parsing $instruction\n");
	}
}

my $nsDistance = ( $nsOffset < 0 ) ? $nsOffset*(-1) : $nsOffset;
my $weDistance = ( $weOffset < 0 ) ? $weOffset*(-1) : $weOffset;

print $nsDistance + $weDistance."\n";
