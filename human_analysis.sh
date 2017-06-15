#!/usr/bin/bash

# call as: screen -d -m srun --partition=harerlab --mem=0 --output=slurm.log ./build_genome.sh
# --mem=0 required to access all memory on node

DATADIR=/work/bc187/Cho_4189_170609A5
GENOMEDIR=/work/bc187/human_genome/star_format

cd $DATADIR

for DIR in `ls -d */`
do
cd $DIR
gzip -d *.gz
cat *.fastq > combined.fastq

mkdir STAR_out_hum

$HOME/programs/STAR/bin/Linux_x86_64/STAR --runThreadN 1 --runMode alignReads --genomeDir $GENOMEDIR --readFilesIn ./combined.fastq --outFilterType BySJout --outFileNamePrefix ./STAR_out_hum/ --outFilterIntronMotifs RemoveNoncanonical

rm combined.fastq
gzip *.fastq

# cd STAR_out_hum
# samtools view -h Aligned.out.sam > Aligned.out.bam
# samtools sort Aligned.out.bam Aligned.out.sorted
# samtools view -h Aligned.out.sorted.bam > Aligned.out.sorted.sam

# htseq-count --order=pos --stranded=reverse --mode=intersection-nonempty --type=exon --idattr=gene_id Aligned.out.sorted.sam <path_to_GFF/GTF_transcriptome_annot> > $FILE.txt

# cuffquant --library-type=fr-firststrand <path_to_GFF/GTF_transcriptome_annot> Aligned.out.sorted.sam

# rm Aligned.out.sam
# rm Aligned.out.bam
# rm Aligned.out.sorted.sam

# cd ..
cd ..
done
