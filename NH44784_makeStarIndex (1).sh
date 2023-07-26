#!/bin/bash
#
#SBATCH --job-name=Starindex
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --partition=short
#SBATCH --time=11:00:00
#SBATCH -o stdout.%j
#SBATCH -e stderr.%j
#SBATCH --mem-per-cpu=4000
#SBATCH --mail-type=ALL
#SBATCH --mail-user=


module load STAR

STAR \
    --runMode genomeGenerate \
    --genomeSAindexNbases 8 \
    --runThreadN 16 \
    --genomeDir ./ \
    --genomeFastaFiles ./AxNH44784_genome.fa \
   
