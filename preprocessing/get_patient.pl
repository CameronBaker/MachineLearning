#!usr/bin/perl

# get_patient.pl
# This is a script to parse the first column from a csv file using Text::CSV
# Due to the permissions when installing Text::CSV, the third use is a path
# to my specific downloads, comment it out on systems including Text::CSV
#
# Cameron Baker

use strict;
use warnings;
use lib './perl5/lib/perl5';
use Text::CSV;

#Text::CSV parser object
my $parser = Text::CSV->new({ sep_char => ',' });

#File taken as an argument
my $file = $ARGV[0] or die "No CSV provided\n";

#Open both that file and an output file
open(my $data, '<', $file) or die "Could not open infile\n";
open(my $outfile,'>','outfile.txt') or die "Could not open outfile\n";

#Iterate through the document, retrieving the first column and writing it to
#the outfile
while(my $line = <$data>){
	chomp $line;
	if($parser->parse($line)){
		my @fields = $parser->fields();
		print $outfile "$fields[0]\n";
	}
}

#close both files
close($data);
close($outfile);
