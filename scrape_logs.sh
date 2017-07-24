#!/usr/bin/bash

# call in top level directory -- /work/bc187/malariadataJuly2017/

SAMPLENUM=$1
SAMPDIR="Sample$SAMPLENUM"
RESULTSDIR="results_$SAMPDIR"

mkdir $RESULTSDIR
cd $SAMPDIR

for DIR in `ls -d */`
do
cd $DIR
ABUNMAL=abundances_"$DIR"_mal.cxb
ABUNHUM=abundances_"$DIR"_hum.cxb
LOGMAL=Log_"$DIR"_mal.final.out
LOGHUM=Log_"$DIR"_hum.final.out

cp -v ./STAR_out_mal/abundances.cxb ../../$RESULTSDIR/$ABUNMAL
cp -v ./STAR_out_mal/Log.final.out ../../$RESULTSDIR/$LOGMAL
cp -v ./STAR_out_hum/abundances.cxb ../../$RESULTSDIR/$ABUNHUM
cp -v ./STAR_out_hum/Log.final.out ../../$RESULTSDIR/$LOGHUM
cd ..
done

