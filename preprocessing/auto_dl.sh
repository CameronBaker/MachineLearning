#!/bin/bash

#Cameron Baker
#This file parses patient codes and retrieves the relevent HTMLS

while read p; do
	t=$(echo $p|tr '\n' ' ')
	wget https://my.pgp-hms.org/profile/$t
done <outfile.txt
