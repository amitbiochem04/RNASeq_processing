#!/bin/bash
#MSUB -e ./htseq.stderr.%j            # stderr file
#MSUB -o ./htseq.stdout.%j            # stdout file
#MSUB -N htseq_run                  # my job's name in the queue
#MSUB -l pmem=5GB
#MSUB -l walltime=12:01:00

export OMP_NUM_THREADS=${MOAB_PROCCOUNT}
echo "Number nodes = ${MOAB_NODECOUNT}"
echo "Number cores = ${MOAB_PROCCOUNT}"

#module load bio/tophat/2.0.11
#module load bio/samtools/0.1.19
#module load bio/bowtie2/2.1.0
######MSUB -l nodes=2:ppn=16

name=$1
index=/home/hd/hd_hd/hd_lo149/genome
out=/home/hd/hd_hd/hd_lo149/alignment
data=/home/hd/hd_hd/hd_lo149/count

htseq-count -f bam \
-r pos \
--type=exon --idattr=gene_id \
--stranded=reverse \
--mode=intersection-nonempty \
${out}/${name}/accepted_hits.bam \
${index}/Neurospora_crassa.NC12.34.gtf > ${data}/${name}.htseq_count.txt

#echo ${name}














