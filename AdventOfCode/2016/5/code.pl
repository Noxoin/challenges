#!/usr/bin/env perl

use strict;
use warnings;

use Digest::MD5 qw( md5_hex );

my $in = <STDIN>;
$in =~ s/\A\s+|\s+\z//g;
my $index = 0;
my $password = "";
for ( my $i = 0; $i < 8; ++$i) {
	my $hash = "";
	while(not ($hash =~ /\A00000/)) {
		$hash = md5_hex("$in$index");
		$index++;
	}
	print $hash."\n";
	my $char = substr($hash,5,1);
	$password .= $char;
}
print $password."\n";
