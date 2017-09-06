#!/usr/bin/bash

REF_PATH='/work/bc187/malariadataJuly2017/REDOWNLOAD_FOR_CHECKSUMS/allfiles/'

SAMPLENUM=$1
SAMPDIR="Sample$SAMPLENUM"
cd $SAMPDIR

for DIR in `ls -d *`
do
echo $DIR
cd $DIR
for FILE in `ls *.fastq.gz`
do
# have reference checksummed .fastq.gz files in current directory
zcmp $FILE "$REF_PATH/$FILE" > temp.txt 

if [[ `wc -l temp.txt`==0 ]];
	then echo "$FILE passed"
else
	echo "$FILE failed"
	echo $FILE >> comparison_checksum_failures.txt
fi
done
cd ..
done
