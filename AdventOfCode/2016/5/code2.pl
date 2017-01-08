#!/usr/bin/env perl

use strict;
use warnings;

use Digest::MD5 qw( md5_hex );

my $in = <STDIN>;
$in =~ s/\A\s+|\s+\z//g;
my $index = 0;
my $password = "zzzzzzzz";
for ( my $i = 0; $i < 8; ++$i) {
	my $hash = "";
	while(not ($hash =~ /\A00000[0-9]/)) {
		$hash = md5_hex("$in$index");
		$index++;
	}
	print $hash."\n";
	my $position = substr($hash,5,1);
	my $char = substr($hash,6,1);
	if ($position > 7 or substr($password, $position, 1) ne "z") {
		redo;
	}
	my $tempPass = "";
	foreach my $j (0..7) {
		if ( $j == $position ) {
			$tempPass .= $char;
		} else {
			$tempPass .= substr($password, $j,1);
		}
	}
	$password = $tempPass;
}
print $password."\n";
