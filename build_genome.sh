#!/usr/bin/bash

# call as: screen -d -m srun --partition=harerlab --mem=0 --output=slurm.log ./build_genome.sh
# --mem=0 required to access all memory on node



# # vivax
# # option --sjdbGTFtagExonParentTranscript Parent  below needed for .gff files, not .gtf files
# $HOME/programs/STAR/bin/Linux_x86_64/STAR --runThreadN 1 --runMode genomeGenerate --genomeDir /work/bc187/vivax_genome/star_format --genomeFastaFiles /work/bc187/vivax_genome/PlasmoDB-32_PvivaxP01_Genome.fasta --sjdbGTFfile /work/bc187/vivax_genome/PlasmoDB-32_PvivaxP01.gff --sjdbGTFtagExonParentTranscript Parent

# human
$HOME/programs/STAR/bin/Linux_x86_64/STAR --runThreadN 1 --runMode genomeGenerate --genomeDir /work/bc187/human_genome/star_format --genomeFastaFiles /work/bc187/human_genome/Homo_sapiens/NCBI/GRCh38/Sequence/WholeGenomeFasta/genome.fa --sjdbGTFfile /work/bc187/human_genome/Homo_sapiens/NCBI/GRCh38/Annotation/Genes.gencode/genes.gtf 
