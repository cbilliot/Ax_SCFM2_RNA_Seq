#!/bin/bash
#
#SBATCH --job-name=
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --partition=express
#SBATCH --time=2:00:00
#SBATCH -o stdout.%j
#SBATCH -e stderr.%j
#SBATCH --mem-per-cpu=2000
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=

module load STAR
module load SAMtools

STAR \
	--genomeDir ./ \
	--runThreadN 16 \
	--readFilesIn ./Ax_LB_1_S42_R1_001_val_1.fq.gz ./Ax_LB_1_S42_R2_001_val_2.fq.gz \
	--outFileNamePrefix Ax_LB_1 \
	--readFilesCommand "gunzip -c" \




#STAR will make a file that looks like samplename_Aligned.out.sam. That goes at the end here.
samtools sort -l 0 -n -o Ax_LB_1_sorted.bam -T Ax_LB_1.tmp Ax_LB_1_Aligned.out.sam