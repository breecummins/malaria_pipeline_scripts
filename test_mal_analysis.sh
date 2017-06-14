#!/usr/bin/bash

#test script for malaria

DATADIR=/work/bc187/Cho_4189_170609A5
GENOMEDIR=/work/bc187/vivax_genome/star_format

cd $DATADIR

for DIR in `ls -d */`
do
cd $DIR
gzip -d *.gz
cat *.fastq > combined.fastq

mkdir STAR_out_mal

$HOME/programs/STAR/bin/Linux_x86_64/STAR --runThreadN 1 --runMode alignReads --genomeDir $GENOMEDIR --readFilesIn ./combined.fastq --outFilterType BySJout --alignIntronMin 10 --alignIntronMax 3000 --outFileNamePrefix ./STAR_out_mal/ --outFilterIntronMotifs RemoveNoncanonical

rm combined.fastq
gzip *.fastq

# cd STAR_out_mal
# samtools view -h Aligned.out.sam > Aligned.out.bam
# samtools sort Aligned.out.bam Aligned.out.sorted
# samtools view -h Aligned.out.sorted.bam > Aligned.out.sorted.sam

# cuffquant --library-type=fr-firststrand <path_to_GFF/GTF_transcriptome_annot> Aligned.out.sorted.sam

# rm Aligned.out.sam
# rm Aligned.out.bam
# rm Aligned.out.sorted.sam

# cd ..
cd ..
done

