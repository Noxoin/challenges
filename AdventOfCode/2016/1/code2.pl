#!/usr/bin/env perl

use strict;
use warnings;

my ( $nsOffset, $weOffset ) = ( 0, 0 );
my $facing = 10000;
my $in = <STDIN>;
my @instructions = split(", ", $in);
my @positions;

push(@positions, [0,0]);

foreach my $instruction ( @instructions ) {
	if ( my ( $direction, $value ) = ( $instruction =~ /^([LR])(\d+)$/) ) {
		if ( $direction eq 'L' ) {
			$facing--;
		} elsif ( $direction eq 'R' ) {
			$facing++;
		} else {
			print("Dafaq is this direction? $direction\n");
		}

		if ( ( $facing % 4 ) == 0 ) {
			$nsOffset += $value;
		} elsif ( ( $facing % 4 ) == 1 ) {
			$weOffset += $value;
		} elsif ( ( $facing % 4 ) == 2 ) {
			$nsOffset -= $value;
		} elsif ( ( $facing % 4 ) == 3 ) {
			$weOffset -= $value;
		} else {
			print("What direction am I facing?!?! $facing\n");
		}

		my $distance = checkIntersection(\@positions, $weOffset, $nsOffset);
		if( $distance > -1) {
			print $distance."\n";
			last;
		}
		push(@positions, [$weOffset, $nsOffset]);

	} else {
		print("Error parsing $instruction\n");
	}
}

sub checkIntersection {
	my ($coords, $x, $y) = @_;

	my ($x1, $y1) = @{@$coords[scalar(@$coords) - 1]};

	for( my $i = 1; $i < scalar(@$coords) - 1; ++$i ) {
		my @coord1 = @{@$coords[$i-1]};
		my @coord2 = @{@$coords[$i]};
		if ($coord1[0] == $coord2[0] ) {
			if(($coord1[1] <= $y and $coord2[1] >= $y) or ($coord1[1] >= $y and $coord2[1] <= $y)) {
				if (($x1 <= $coord1[0] and $x >= $coord1[0] ) or ($x1 >= $coord1[0] and $x1 <= $coord1[0])) {
					return abs($coord1[0]) + abs($y);
				}
			}
		} else {
			if(($coord1[0] <= $x and $coord2[0] >= $x) or ($coord1[0] >= $x and $coord2[0] <= $x)) {
				if (($y1 <= $coord1[1] and $y >= $coord1[1] ) or ($y1 >= $coord1[1] and $y1 <= $coord1[1])) {
					return abs($coord1[1]) + abs($x);
				}
			}
		}
	}
	return -1;
}
