#!/usr/bin/env perl

use strict;
use warnings;

my @letterFreq = ( {}, {}, {}, {}, {}, {}, {}, {} );
while ( 1 ) {
	my $in = <STDIN>;
	$in =~ s/\A\s+|\s+\z//g;
	if ($in eq "") {
		last;
	}
	my $i = 0;
	foreach my $char ( split(//, $in) ) {
		if ( not exists $letterFreq[$i]->{$char} ) {
			$letterFreq[$i]->{$char} = 1;
		} else {
			$letterFreq[$i]->{$char}++;
		}
		$i++;
	}
}

my $msg = "";
foreach my $hash ( @letterFreq ) {
	my @sorted = sort {$a->[0] <=> $b->[0]} map { [$hash->{$_}, $_] } keys %$hash;
	$msg .= $sorted[0][1];
}

print $msg;
