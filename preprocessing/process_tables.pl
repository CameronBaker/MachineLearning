#!usr/bin/perl

# process_tables.pl 
# This is a script to parse specific columns from a csv file using Text::CSV
# It then writes those columns to a file with the name of the first column
#
# Due to the permissions when installing Text::CSV, the third use is a path
# to my specific downloads, comment it out on systems including Text::CSV
#
# Cameron Baker

use strict;
use warnings;
use lib '../perl5/lib/perl5';
use Text::CSV;

#Create parser object and open specified file
my $parser = Text::CSV->new({sep_char => ' '});
my $file = $ARGV[0] or die "No csv provided \n";

open(my $data, '<', $file) or die "could not open\n";

#Skip the header and iterate through the file
$parser->getline($data);
while(my $line = <$data>){
	chomp $line;
	if($parser->parse($line)){
		#The structure of the tail end of the columns messes up
		#simple array operations, so additional processing is needed
		my @fields = $parser->fields();
		my @filename = split /_/, $ARGV[0];
		my @truefields = split /\t/, $fields[0];
		#print "$truefields[0], $truefields[4], $truefields[5]\n";

		#open the OTU file for OTU in the line on append
		open(my $OTU, '>>', $truefields[0]);
		
		#Print relevent data
		print $OTU "$filename[0],$truefields[4],$truefields[5]\n";	
		#close OTU file
		close($OTU);
	}
}

#Close argument file
close($data);
