#!/usr/bin/bash

input=$1 #Sample10links.txt

while read -r LINK
do 
	DIRNAME=${LINK:(-10):5}
	ZIPNAME="${DIRNAME/-/_}.zip"
	wget -O $ZIPNAME $LINK
	unzip $ZIPNAME
	rm $ZIPNAME
done < $input
