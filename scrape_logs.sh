#!/usr/bin/bash

# call in top level directory -- /work/bc187/malariadataJuly2017/

SAMPLENUM=$1
SAMPDIR="Sample$SAMPLENUM"
RESULTSDIR="results_$SAMPDIR"

mkdir RESULTSDIR
cd SAMPDIR

for DIR in `ls -d */`
do
cd $DIR
cp ./STAR_out_mal/abundances.cxb ../../$RESULTSDIR/abundances_$DIR_mal.cxb
cp ./STAR_out_mal/Log.final.out ../../$RESULTSDIR/Log_$DIR_mal.final.out
cp ./STAR_out_hum/abundances.cxb ../../$RESULTSDIR/abundances_$DIR_hum.cxb
cp ./STAR_out_hum/Log.final.out ../../$RESULTSDIR/Log_$DIR_hum.final.out
cd ..
done

