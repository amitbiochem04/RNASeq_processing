#!/bin/bash
#MSUB -e ./stringtie.stderr.%j            # stderr file
#MSUB -o ./stringtie.stdout.%j            # stdout file
#MSUB -N tophat_run                  # my job's name in the queue
#MSUB -l pmem=20GB
#MSUB -l walltime=12:01:00

export OMP_NUM_THREADS=${MOAB_PROCCOUNT}
echo "Number nodes = ${MOAB_NODECOUNT}"
echo "Number cores = ${MOAB_PROCCOUNT}"
#module load bio/tophat/2.0.11
#module load bio/samtools/0.1.19
#module load bio/bowtie2/2.1.0

######MSUB -l nodes=2:ppn=16
name=$1
out=/home/hd/hd_hd/hd_lo149/alignment
data=/home/hd/hd_hd/hd_lo149/hist_stringtie
#stringtie \
#-G ${gtf}/Chaetomium_REVERSEDSTRAND.gtf \
stringtie -o ${data}/${name}.gtf \
${out}/${name}_sort.bam \
-m 50 \
-p 8 \
-j 3 \
-c 5 \
-g 15 

