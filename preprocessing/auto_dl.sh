#!/bin/bash
# auto_dl.sh
# This file parses patient id's from a file line by line and retrieves
# the html file relating to the patient
#
# Cameron Baker

while read p; do
	#Parse out newline character
	t=$(echo $p|tr '\n' ' ')	
	#get file relating to specific ID
	wget https://my.pgp-hms.org/profile/$t
done <outfile.txt
