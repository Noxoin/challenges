#!/usr/bin/env perl

use strict;
use warnings;

use Data::Dumper;

my $decomLen = 0;
my @file;

open(my $fh, '<', "in") or die "Couldn't open file 'in' $!";

my $line = <$fh>;
$line =~ s/\A\s+|\s+\z//g;
push @file, split(//, $line);

while ( scalar(@file) > 0 ) {
	my $char = shift @file;
	if ( $char eq "(" ) {
		my $instruct = "";
		$char = shift @file;
		while($char ne ")") {
			$instruct .= $char;
			$char = shift @file;
		}
		my ($a, $b) = ($instruct =~ /(\d+)x(\d+)/);
		my @seq;
		for my $i (0..$a-1) {
			$char = shift @file;
			push @seq, $char;
			if(not defined $char) {
				print join("", @seq);
				print join("", @file);
			}
		}
		#for (0..$b-1) {
		#	push @decom, @seq;
		#}
		$decomLen += $a*$b;
	} else {
		#push @decom, $char;
		$decomLen++;
	}
}
print $decomLen."\n";
