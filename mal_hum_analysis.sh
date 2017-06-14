#!/usr/bin/bash

#Tina's script for malaria and human genome

for FILE in `ls`
do
cd $FILE
gzip -d *.gz
cat *.fastq > combined.fastq

mkdir STAR_out_mal

STAR --runThreadN 1 --runMode alignReads --genomeDir <path_to_STAR_genomebuild> --readFilesIn ./combined.fastq --outFilterType BySJout --alignIntronMin 10 --alignIntronMax 3000 --outFileNamePrefix ./STAR_out_mal/ --outFilterIntronMotifs RemoveNoncanonical

mkdir STAR_out_hum

STAR --runThreadN 1 --runMode alignReads --genomeDir <path_to_STAR_genomebuild> --readFilesIn ./combined.fastq --outFilterType BySJout --outFileNamePrefix ./STAR_out_hum/ --outFilterIntronMotifs RemoveNoncanonical

rm combined.fastq
gzip *.fastq

cd STAR_out_mal
samtools view -h Aligned.out.sam > Aligned.out.bam
samtools sort Aligned.out.bam Aligned.out.sorted
samtools view -h Aligned.out.sorted.bam > Aligned.out.sorted.sam

htseq-count --order=pos --stranded=reverse --mode=intersection-nonempty --type=gene --idattr=ID Aligned.out.sorted.sam <path_to_GFF/GTF_transcriptome_annot> > $FILE.txt

cuffquant --library-type=fr-firststrand <path_to_GFF/GTF_transcriptome_annot> Aligned.out.sorted.sam

rm Aligned.out.sam
rm Aligned.out.bam
rm Aligned.out.sorted.sam

cd ..
cd STAR_out_hum
samtools view -h Aligned.out.sam > Aligned.out.bam
samtools sort Aligned.out.bam Aligned.out.sorted
samtools view -h Aligned.out.sorted.bam > Aligned.out.sorted.sam

htseq-count --order=pos --stranded=reverse --mode=intersection-nonempty --type=exon --idattr=gene_id Aligned.out.sorted.sam <path_to_GFF/GTF_transcriptome_annot> > $FILE.txt

cuffquant --library-type=fr-firststrand <path_to_GFF/GTF_transcriptome_annot> Aligned.out.sorted.sam

rm Aligned.out.sam
rm Aligned.out.bam
rm Aligned.out.sorted.sam

cd ..
cd ..
done
