#!/usr/bin/bash

# Altered Tina's script for malaria and human genome

# call as: screen -d -m srun --partition=harerlab --mem=0 --output=slurm.log ./mal_hum_analysis2.sh <top level data dir>
# --mem=0 required to access all memory on node

# DATADIR=/work/bc187/Cho_4189_170609A5
DATADIR=$1

MALGENOMEDIR=/work/bc187/vivax_genome/star_format
MALGFFPATH=/work/bc187/vivax_genome/PlasmoDB-32_PvivaxP01.gff
HUMGENOMEDIR=/work/bc187/human_genome/star_format
HUMGFFPATH=/work/bc187/human_genome/Homo_sapiens/NCBI/GRCh38/Annotation/Genes.gencode/genes.gtf

cd $DATADIR

for DIR in `ls -d */`
do
cd $DIR
gzip -d *.gz
cat *.fastq > combined.fastq
gzip O*.fastq

mkdir STAR_out_mal
mkdir STAR_out_hum

STAR --runThreadN 1 --runMode alignReads --genomeDir $MALGENOMEDIR --readFilesIn ./combined.fastq --outFilterType BySJout --alignIntronMin 10 --alignIntronMax 3000 --outFileNamePrefix ./STAR_out_mal/ --outFilterIntronMotifs RemoveNoncanonical

cd STAR_out_mal
samtools view -h Aligned.out.sam > Aligned.out.bam
samtools sort -o Aligned.out.sorted.bam Aligned.out.bam
# samtools view -h Aligned.out.sorted.bam > Aligned.out.sorted.sam
# cuffquant --library-type=fr-firststrand $MALGFFPATH Aligned.out.sorted.sam
cuffquant --library-type=fr-firststrand $MALGFFPATH Aligned.out.sorted.bam


rm Aligned.out.sam
rm Aligned.out.bam
# rm Aligned.out.sorted.sam
rm Aligned.out.sorted.bam

cd ..

STAR --runThreadN 1 --runMode alignReads --genomeDir $HUMGENOMEDIR --readFilesIn ./combined.fastq --outFilterType BySJout --outFileNamePrefix ./STAR_out_hum/ --outFilterIntronMotifs RemoveNoncanonical

rm combined.fastq

cd STAR_out_hum
samtools view -h Aligned.out.sam > Aligned.out.bam
samtools sort -o Aligned.out.sorted.bam Aligned.out.bam
# samtools view -h Aligned.out.sorted.bam > Aligned.out.sorted.sam
# cuffquant --library-type=fr-firststrand $HUMGFFPATH Aligned.out.sorted.sam
cuffquant --library-type=fr-firststrand $HUMGFFPATH Aligned.out.sorted.bam

rm Aligned.out.sam
rm Aligned.out.bam
# rm Aligned.out.sorted.sam
rm Aligned.out.sorted.bam


cd ../..
done
