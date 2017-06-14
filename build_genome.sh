# call as: screen -d -m srun --partition=harerlab ./build_genome.sh


$HOME/programs/STAR/bin/Linux_x86_64/STAR --runThreadN 1 --runMode genomeGenerate --genomeDir /work/bc187/vivax_genome/star_format --genomeFastaFiles /work/bc187/vivax_genome/PlasmoDB-32_PvivaxP01_Genome.fasta --sjdbGTFfile /work/bc187/vivax_genome/PlasmoDB-32_PvivaxP01.gff