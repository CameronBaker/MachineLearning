#!/bin/bash

# retrieve_data.sh
# this script iterates through a list of html files and downloads microbiome
# data from links within those files
#
# Cameron Baker

while read p; do
	t=$(echo $p|tr -d '\n' )
	fname=$(perl parse_html.pl $t)
	wget $fname -O $t.data
done <outfile.txt
