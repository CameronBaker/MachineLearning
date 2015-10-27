#!/bin/bash

# get_tables.sh
# This script parses the Stool data out of patients located within a list
# of the directory and calls a perl script that extracts otus from that data
#
# Cameron Baker

while read p; do
	t=$(echo $p | cut -f1 -d_)
	#Copy the file out of the directory
	cp $p/$t/otu_category_significance/otu_cat_sig_Stool.txt ${t}_stool.txt
	#extracts data from the copied file	
	perl process_tables.pl ${t}_stool.txt
done < outfile.txt

