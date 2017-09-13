#!/usr/bin/bash

# call in results folder with aggregated .cxb files

mkdir fpkm_mal
cd fpkm_mal
~/programs/cufflinks-2.2.1.Linux_x86_64/cuffnorm --library-type=fr-firststrand /work/bc187/vivax_genome/PlasmoDB-32_PvivaxP01.gff ../*mal.cxb

cd ..
mkdir fpkm_hum
cd fpkm_hum
~/programs/cufflinks-2.2.1.Linux_x86_64/cuffnorm --library-type=fr-firststrand /work/bc187/human_genome/Homo_sapiens/NCBI/GRCh38/Annotation/Genes.gencode/genes.gtf ../*hum.cxb

cd ..
