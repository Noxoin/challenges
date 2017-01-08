#!/usr/bin/env perl

use strict;
use warnings;

use Data::Dumper;

sub getABA {
	my ($string) = @_;
	my $length = length($string);
	my @ABA;
	for ( my $i = 0; $i < $length - 2; ++$i ) {
		if(substr($string, $i, 1) eq substr($string, $i+2, 1)) {
			if(substr($string, $i, 1) ne substr($string, $i+1, 1)) {
				push @ABA, substr($string, $i, 3);
			}
		}
	}
	return \@ABA;
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
	my @pos;
	foreach my $string ( @positive ) {
		my $aba = getABA($string);
		push @pos, @$aba;
	}
	foreach my $string ( @negative ) {
		foreach my $aba ( @pos ) {
			my $bab = substr($aba, 1, 1).substr($aba, 0, 2);
			if ( $string =~ /$bab/ ) {
				$count++;
				next MAIN;
			}
		}
	}
}

print $count;

