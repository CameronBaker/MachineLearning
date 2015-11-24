#!usr/bin/perl

# Cameron Baker
# This file handles the traversal of the microbiome data directories
# and is responsible for the final organization of OTU data

use strict;
use warnings;
use lib '../perl5/lib/perl5';
use Text::CSV;

my $parser = Text::CSV->new({sep_char => ' '});
my $file = $ARGV[0] or die "No csv provided \n";

open(my $data, '<', $file) or die "could not open\n";
while(my $line = <$data>){
	chomp $line;

	#The following chunk of code enters into patient directories and 
	#retrieves information regarding the filenames for future use in pathing
	my $directory = $line;
	opendir(my $DIR, $directory) or die $!;
	my @results_dir = readdir $DIR;
	my $results_dir_name;
	my $health_file_name;
	foreach my $value (@results_dir){
		if($value =~ /results/){
			$results_dir_name = $value;
			print "$results_dir_name\n";
		}
		if($value =~ /health/){
			$health_file_name = $value;
		}
	}
	
	#Processing of filenames and paths. Also prints for operator checking
	$health_file_name = './' . $line . '/' . $health_file_name;
	print "$health_file_name\n";
	open my $health_file, '<', $health_file_name;
	my $affliction = <$health_file>;
	print "$affliction\n";

	#Actual traversal through to the microbiome data, using the paths as determined above
	my @patient_name = split /_/, $results_dir_name;
	my $file_path= './' . $line . '/' . $results_dir_name .'/'. $patient_name[0]. '/otu_category_significance/otu_cat_sig_Stool.txt'; 
	print "$file_path\n";
	eval{
		open(my $stool_data, '<', $file_path);	

		#For each row in the stool microbiome data file, write that OTU's information to
		#its specific file
		while(my $stool_data_line = <$stool_data>){
			next if $.==1;
			if($parser->parse($stool_data_line)){
				my @fields = $parser->fields();
				my @filename = split /_/, $ARGV[0];
				my @truefields = split /\t/, $fields[0];
				#print "$truefields[0], $truefields[4], $truefields[5]\n";
				open(my $OTU, '>>', $truefields[0]);
				print $OTU "$line,$truefields[4],$truefields[5],$affliction";	
				close($OTU);
			}
		}
	}
}
close($data);

