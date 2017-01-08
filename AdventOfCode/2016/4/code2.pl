#!/usr/bin/env perl

use strict;
use warnings;

my @validRooms;
MAIN: while ( 1 ) {
	my $in = <STDIN>;
	$in =~ s/\A\s+|\s+\z//g;
	if ( $in eq "" ) {
		last;
	}
	my ( $name, $id, $check ) = ( $in =~ /\A(.*)-(\d+)\[([a-z]{5})\]\z/ ) ;
	my %charfreq;
	foreach my $char ( split( //, $name) ) {
		if ( $char eq "-" ) {
			next;
		}
		if ( not exists $charfreq{$char} ) {
			$charfreq{$char} = 1;
		} else {
			$charfreq{$char}++;
		}
	}

	my @freq = sort { $b->[0] <=> $a->[0] || $a->[1] cmp $b->[1] } map { [$charfreq{$_}, $_] } keys %charfreq;

	my %checkHash;
	foreach my $char ( split( //, $check) ) {
		$checkHash{$char} = 1;
	}

	for ( my $i = 0; $i < 5; ++$i ) {
		if ( not exists $checkHash{$freq[$i][1]} ) {
			next MAIN;
		}
	}

	my $decodedName = "";
	foreach my $char ( split( //, $name) ) {
		if ( $char eq "-" ) {
			$decodedName .= " ";
			next;
		}
		my $num = ord($char) - 97;
		print $num;
		$num = ($num + $id) % 26;
		$decodedName .= chr($num+97);
	}
	push @validRooms, "$decodedName: $id\n";
}
print sort @validRooms;
