#!/usr/bin/perl

# parse_html.pl
# This script iterates through an HTML file and parses out the specific
# lines containing the download link for the microbiome data
# 
# called by retrieve_data.sh
# Cameron Baker

use strict;
use warnings;

#Open and iterate through file
open my $fh, '<', $ARGV[0];
while(my $line = <$fh>){
	#if that line contains specified string
	if(index($line,"download_nickname=Microbiome") != -1){
		#parse nonimportant parts from the string and print it
		my @parts = split /"/, $line; 
		$parts[1] =~ s/&amp;/&/g;
		my $part = $parts[1];	
		print "$part\n";
	}
}
#close file
close $fh;
