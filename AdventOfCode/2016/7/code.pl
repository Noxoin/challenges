#!/usr/bin/env perl

use strict;
use warnings;

use Data::Dumper;

sub containsABBA {
	my ($string) = @_;
	my $length = length($string);
	for ( my $i = 0; $i < $length - 3; ++$i ) {
		if(substr($string, $i, 1) eq substr($string, $i+3, 1)) {
			if(substr($string, $i+1, 1) eq substr($string, $i+2, 1)) {
				if(substr($string, $i, 1) ne substr($string, $i+1, 1)) {
					return 1;
				}
			}
		}
	}
	return 0;
}

my $count = 0;
MAIN: while ( 1 ) {
	my $in = <STDIN>;
	$in =~ s/\A\s+|\s\z//g;
	if ( $in eq "" ) {
		last;
	}
	my @positive = split( /\[[a-z]+\]/, $in );
	$in =~ s/\A[a-z]*\[|\][a-z]*\z//g;
	my @negative = split( /\][a-z]*\[/, $in );
	print Dumper(@positive);
	print Dumper(@negative);
	my $pos = 0;
	my $neg = 0;
	foreach my $string ( @positive ) {
		if (containsABBA($string)) {
			$pos++;
			last;
		}
	}
	foreach my $string ( @negative ) {
		if (containsABBA($string)) {
			$neg++;
			last;
		}
	}
	if ( $pos and not $neg ) {
		$count++;
	}
}

print $count;

