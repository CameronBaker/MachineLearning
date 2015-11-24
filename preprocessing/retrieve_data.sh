#!/bin/bash

while read p; do
	t=$(echo $p|tr -d '\n' )
	fname=$(perl parse_html.pl $t)
	wget $fname -O $t.data
done <outfile.txt
