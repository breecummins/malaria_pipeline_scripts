#!/usr/bin/bash

PATH_TO_FNAME=$1
FNAME=$(basename $PATH_TO_FNAME)

# have reference checksummed .fastq.gz files in current directory

zcmp $FNAME $PATH_TO_FNAME > temp.txt 

if [[ -s temp.txt ]]; 
	then echo "Passed"
else
	echo $FNAME >> comparison_checksum_failures.txt
fi