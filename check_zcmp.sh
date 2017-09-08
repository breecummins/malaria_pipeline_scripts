#!/usr/bin/bash

REF_PATH='/work/bc187/malariadataJuly2017/REDOWNLOAD_FOR_CHECKSUMS/allfiles/'
cd $1 #example argument: /work/bc187/malariadataJuly2017/Sample10/firstrun

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
	echo $FILE >> zcmp_failures.txt
fi
done
cd ..
done
