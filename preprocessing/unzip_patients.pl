#!usr/bin/perl

# unzip_patient.pl
# This script uses the text parsing within perl to facilitate
# the passing on of meta information not normally included
# within the bash commands

use strict;
use warnings;
use lib './perl5/lib/perl5';
use Text::CSV;

#Text::CSV parser object
my $parser = Text::CSV->new({sep_char => ','});

#Opening of the input file and digestive survey
open(my $in, '<', "in") or die "Could not open infile\n";

#parse .data out of lines
while(my $line = <$in>){
	chomp $line;
	my @values = split(/\./, $line);
	my $patient_desig = $values[0];
	
	#print "$line\n";
	#print "$patient_desig \n";
	
	my $has_IBS = 0;
	my $has_GERD = 0;	
	open(my $survey, '<', "dig_survey") or die "Could not open dig_survey\n";

	#Medical information relating to the patient is parsed out of the digestive survey
	while(my $row = <$survey>){
		if($row =~ $patient_desig){
			if($row =~ /IBS/){
				$has_IBS = 1;
			}
			if($row =~ /GERD/){
				$has_GERD = 1;
			}
		}
	}
	close $survey;

	#Create a file within the patients directory denoting their medical status
	#for easy retrieval
	system("mkdir './$patient_desig/'");
	system("unzip '$line' -d ./$patient_desig/");
	my $health_fn = $patient_desig . '_health';
	#print "$health_fn\n";
	open(my $health_file, '>', $health_fn);

	if($has_IBS && $has_GERD){
		print $health_file "Both\n";
	}elsif($has_IBS){
		print $health_file "IBS\n";
	}elsif($has_GERD){
		print $health_file "GERD\n";
	}else{
		print $health_file "Healthy\n";
	}
	close $health_file;
	system("mv $health_fn $patient_desig");
}
close $in;
