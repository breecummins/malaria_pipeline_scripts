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

mkdir STAR_out_mal

STAR --runThreadN 1 --runMode alignReads --genomeDir $MALGENOMEDIR --readFilesIn ./combined.fastq --outFilterType BySJout --alignIntronMin 10 --alignIntronMax 3000 --outFileNamePrefix ./STAR_out_mal/ --outFilterIntronMotifs RemoveNoncanonical

mkdir STAR_out_hum

STAR --runThreadN 1 --runMode alignReads --genomeDir $HUMGENOMEDIR --readFilesIn ./combined.fastq --outFilterType BySJout --outFileNamePrefix ./STAR_out_hum/ --outFilterIntronMotifs RemoveNoncanonical

rm combined.fastq
gzip *.fastq

cd STAR_out_mal
samtools view -h Aligned.out.sam > Aligned.out.bam
samtools sort Aligned.out.bam > Aligned.out.sorted
samtools view -h Aligned.out.sorted.bam > Aligned.out.sorted.sam

# htseq-count --order=pos --stranded=reverse --mode=intersection-nonempty --type=gene --idattr=ID Aligned.out.sorted.sam $MALGFFPATH > $DIR.txt

cuffquant --library-type=fr-firststrand $MALGFFPATH Aligned.out.sorted.sam

rm Aligned.out.sam
rm Aligned.out.bam
rm Aligned.out.sorted.sam

cd ../STAR_out_hum
samtools view -h Aligned.out.sam > Aligned.out.bam
samtools sort Aligned.out.bam > Aligned.out.sorted
samtools view -h Aligned.out.sorted.bam > Aligned.out.sorted.sam

# htseq-count --order=pos --stranded=reverse --mode=intersection-nonempty --type=exon --idattr=gene_id Aligned.out.sorted.sam $HUMGFFPATH > $DIR.txt

cuffquant --library-type=fr-firststrand $HUMGFFPATH Aligned.out.sorted.sam

rm Aligned.out.sam
rm Aligned.out.bam
rm Aligned.out.sorted.sam

cd ../..
done
