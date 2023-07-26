#!/bin/bash
#
#SBATCH --job-name=
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --partition=short
#SBATCH --time=5:00:00
#SBATCH -o stdout.%j
#SBATCH -e stderr.%j
#SBATCH --mem-per-cpu=8000
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=

#Before you start, make sure your files to be trimmed are in the same directory as this script, and that you have made a new folder "trim_qc" to collect all of the quality control reports

module load Trim_Galore

trim_galore --paired --fastqc_args "--nogroup --noextract -o ./trim_qc/" ./Ax_LB_1_S42_R1_001.fastq.gz ./Ax_LB_1_S42_R2_001.fastq.gz
trim_galore --paired --fastqc_args "--nogroup --noextract -o ./trim_qc/" ./Ax_LB_2_S43_R1_001.fastq.gz ./Ax_LB_2_S43_R2_001.fastq.gz
trim_galore --paired --fastqc_args "--nogroup --noextract -o ./trim_qc/" ./Ax_LB_3_S44_R1_001.fastq.gz ./Ax_LB_3_S44_R2_001.fastq.gz
trim_galore --paired --fastqc_args "--nogroup --noextract -o ./trim_qc/" ./Ax_SCFM_1_S39_R1_001.fastq.gz ./Ax_SCFM_1_S39_R2_001.fastq.gz
trim_galore --paired --fastqc_args "--nogroup --noextract -o ./trim_qc/" ./Ax_SCFM_2_S40_R1_001.fastq.gz ./Ax_SCFM_2_S40_R2_001.fastq.gz
trim_galore --paired --fastqc_args "--nogroup --noextract -o ./trim_qc/" ./Ax_SCFM_6_S41_R1_001.fastq.gz ./Ax_SCFM_6_S41_R2_001.fastq.gz

#Example 
#trim_galore --paired --fastqc_args "--nogroup --noextract -o ./trim_qc/" ./Ax_LB_1_S42_R1_001.fastq.gz ./Ax_LB_1_S42_R2_001.fastq.gz