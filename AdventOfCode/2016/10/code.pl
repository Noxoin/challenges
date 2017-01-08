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

MAIN: while ( 1 ) {
	for my $i ( 0 .. scalar(@holdings)-1 ) {
		my $holding = $holdings[$i];
		if ( defined $holding and scalar(@$holding) == 2 ) {
			if ( $holding->[0] == 17 and $holding->[1] == 61 ) {
				print "$i\n";
				last MAIN;
			}
			if ( ( $instructions[$i][0] eq "output" or checkFree($instructions[$i][1]) )
					and ($instructions[$i][2] eq "output" or checkFree($instructions[$i][3]) ) ) {
				if ( $instructions[$i][0] eq "bot" ) {
					insertValue( $instructions[$i][1], $holdings[$i][0] );
				}
				if ( $instructions[$i][2] eq "bot" ) {
					insertValue( $instructions[$i][3], $holdings[$i][1] );
				}
				$holdings[$i] = ();
			}
		}
	}
}
