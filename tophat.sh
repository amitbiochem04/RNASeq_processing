#!/bin/bash
#MSUB -e ./tophat.stderr.%j            # stderr file
#MSUB -o ./tophat.stdout.%j            # stdout file
#MSUB -N tophat_run                  # my job's name in the queue
#MSUB -l pmem=20GB
#MSUB -l walltime=12:01:00

export OMP_NUM_THREADS=${MOAB_PROCCOUNT}
echo "Number nodes = ${MOAB_NODECOUNT}"
echo "Number cores = ${MOAB_PROCCOUNT}"
module load bio/tophat/2.0.11
module load bio/samtools/0.1.19
module load bio/bowtie2/2.1.0

######MSUB -l nodes=2:ppn=16
name=$1
index=/home/hd/hd_hd/hd_lo149/genome
out=/home/hd/hd_hd/hd_lo149/alignment
#data=/home/hd/hd_hd/hd_lo149/data/Dfrq_44-66
#data=/home/hd/hd_hd/hd_lo149/ncbi/public/sra
#data=/home/hd/hd_hd/hd_lo149/data/WT_0-22
#data=/home/hd/hd_hd/hd_lo149/data/WT_44-66
data=/home/hd/hd_hd/hd_lo149/data/Dfrq_0-22
tophat -p 8 -G ${index}/Neurospora_crassa.NC12.34.gtf -o ${out}/${name} -i 10 -I 5000 --transcriptome-index= ${index}/neurospora_crassa_bowtie_index ${data}/${name}.fastq
samtools index ${out}/${name}/accepted_hits.bam
#tophat -p 8 -G ${index}/Neurospora_crassa.NC12.34.gtf -o ${out}/${name} -i 10 -I 5000 --transcriptome-index= ${index}/neurospora_crassa_bowtie_index ${data}/${name}.fastq


