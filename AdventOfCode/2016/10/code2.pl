#!/usr/bin/env perl

use strict;
use warnings;

use Data::Dumper;

my @instructions;
my @holdings;
my @outputs;

sub checkFree {
	my ( $bot ) = @_;
	if ( defined $holdings[$bot] and scalar ( @{$holdings[$bot]} ) == 2 ) {
		return 0;
	}
	return 1;
}

sub insertValue {
	my ( $bot, $val ) = @_;

	if ( not defined $holdings[$bot] or scalar ( @{$holdings[$bot]} ) == 0 or $holdings[$bot][0] < $val) {
		push @{$holdings[$bot]}, $val;
	} else {
		unshift @{$holdings[$bot]}, $val;
	}
}

while ( 1 ) {
	my $line = <STDIN>;
	$line =~ s/\A\s+|\s+\z//g;
	if ( $line eq "" ) {
		last;
	}

	if ( my ( $val, $bot ) = ( $line =~ /value (\d+) goes to bot (\d+)/ ) ) {
		insertValue( $bot, $val );
	} elsif ( my ( $b, $lowType, $low, $highType, $high ) = ( $line =~ /bot (\d+) gives low to (bot|output) (\d+) and high to (bot|output) (\d+)/ ) ) {
		$instructions[$b] = [$lowType, $low, $highType, $high];
	} else {
		print "Don't know this action: $line\n";
	}
}

my $continue = 1;
MAIN: while ( $continue ) {
	my $countEmpty = 0;
	for my $i ( 0 .. scalar(@holdings)-1 ) {
		my $holding = $holdings[$i];
		if ( not defined $holding or scalar(@$holding) == 0 ) {
			$countEmpty++;
		}
		if ( defined $holding and scalar(@$holding) == 2 ) {
			if ( ( $instructions[$i][0] eq "output" or checkFree($instructions[$i][1]) )
					and ($instructions[$i][2] eq "output" or checkFree($instructions[$i][3]) ) ) {
				if ( $instructions[$i][0] eq "bot" ) {
					insertValue( $instructions[$i][1], $holdings[$i][0] );
				} else {
					push @{$outputs[$instructions[$i][1]]}, $holdings[$i][0];
				}
				if ( $instructions[$i][2] eq "bot" ) {
					insertValue( $instructions[$i][3], $holdings[$i][1] );
				} else {
					push @{$outputs[$instructions[$i][3]]}, $holdings[$i][1];
				}
				$holdings[$i] = ();
			}
		}
	}
	if($countEmpty == scalar(@instructions)) {
		last;
	}
}

print $outputs[0][0]*$outputs[1][0]*$outputs[2][0]."\n";
