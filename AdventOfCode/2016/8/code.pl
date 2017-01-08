#!/usr/bin/env perl

use strict;
use warnings;

my @display = (".") x (300);

sub rect {
	my ($a, $b) = @_;
	for my $i (0..$a-1) {
		for my $j (0..$b-1) {
			$display[50*$j+$i] = "#";
		}
	}
}

sub rotateRow {
	my ($a, $b) = @_;
	$b = $b % 50;
	$b = 50 - $b;
	my @temps;
	for my $i (0..$b-1) {
		push @temps, $display[50*$a+$i];
	}
	for my $i ($b..49) {
		$display[50*$a+$i-$b] = $display[50*$a+$i];
	}
	for my $i (0..$b-1) {
		$display[50*$a+50-$b+$i] = $temps[$i];
	}
}

sub rotateCol {
	my ($a, $b) = @_;
	$b = $b % 6;
	$b = 6 - $b;
	my @temps;
	for my $i (0..$b-1) {
		push @temps, $display[50*$i+$a];
	}
	for my $i ($b..5) {
		$display[50*($i-$b)+$a] = $display[50*$i+$a];
	}
	for my $i (0..$b-1) {
		$display[50*(6-$b+$i)+$a] = $temps[$i];
	}
}

sub countTotal {
	my $count = 0;
	foreach my $i ( @display ) {
		if ( $i eq "#") {
			$count++;
		}
	}
	return $count;
}

sub printDisplay {
	my $count = 0;
	foreach my $i ( @display ) {
		print $i;
		$count++;
		if ( $count % 50 == 0) {
			print "\n";
		}
	}
}

while ( 1 ) {
	my $line = <STDIN>;
	$line =~ s/\A\s+|\s+\z//g;
	if ( $line eq "" ) {
		last;
	}
	my ($a, $b);
	if ( ($a, $b) = ($line =~ /rect (\d+)x(\d+)/) ) {
		rect($a, $b);
	} elsif ( ($a, $b) = ($line =~ /rotate column x=(\d+) by (\d+)/) ) {
		rotateCol($a, $b);
	} elsif ( ($a, $b) = ($line =~ /rotate row y=(\d+) by (\d+)/) ) {
		rotateRow($a, $b);
	} else {
		print "Don't know this fuking thing\n";
	}
	printDisplay();
}

print countTotal();
