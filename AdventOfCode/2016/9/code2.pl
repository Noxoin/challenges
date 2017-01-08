#!/usr/bin/env perl

use strict;
use warnings;

use Data::Dumper;

my @file;

sub decompress {
	my ($data) = @_;
	if ( not ( $data =~ /(\d+)x(\d+)/) ) {
		return length($data);
	}
	my $decomLen = 0;
	my @ar = split(//, $data);
	while ( scalar(@ar) > 0 ) {
		my $char = shift @ar;
		if ( $char eq "(" ) {
			my $instruct = "";
			$char = shift @ar;
			while($char ne ")") {
				$instruct .= $char;
				$char = shift @ar;
			}
			my ($a, $b) = ($instruct =~ /(\d+)x(\d+)/);
			my @seq;
			for my $i (0..$a-1) {
				$char = shift @ar;
				push @seq, $char;
			}
			$decomLen += $b * decompress(join("", @seq));
		} else {
			$decomLen++;
		}
	}
	return $decomLen;
}

open(my $fh, '<', "in") or die "Couldn't open file 'in' $!";

my $line = <$fh>;
$line =~ s/\A\s+|\s+\z//g;

print decompress($line)."\n";
