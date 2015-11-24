#!/usr/bin/perl

use strict;
use warnings;

open my $fh, '<', $ARGV[0];
while(my $line = <$fh>){
	if(index($line,"download_nickname=Microbiome") != -1){
		my @parts = split /"/, $line; 
		$parts[1] =~ s/&amp;/&/g;
		my $part = $parts[1];	
		print "$part\n";
	}
}
close $fh;
