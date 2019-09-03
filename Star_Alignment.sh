#!/bin/bash
#MSUB -e ./star.stderr.%j            # stderr file
#MSUB -o ./star.stdout.%j            # stdout file
#MSUB -N star_run                  # my job's name in the queue
##MSUB -l nodes=1:ppn=4
#MSUB -l pmem=62GB
#MSUB -l walltime=50:01:00

export OMP_NUM_THREADS=${MOAB_PROCCOUNT}
echo "Number nodes = ${MOAB_NODECOUNT}"
echo "Number cores = ${MOAB_PROCCOUNT}"

#module load bio/tophat/2.0.11
#module load bio/samtools/0.1.19
#module load bio/bowtie2/2.1.0

name=$1

gtf=/home/hd/hd_hd/hd_lo149/genome/star_genome/mouse
data=/home/hd/hd_hd/hd_lo149/data/data2
#out=/home/hd/hd_hd/hd_lo149/alignment2
out=/work/hd/hd_hd/hd_lo149/alignment
STAR --runThreadN 8 --genomeDir ${gtf} --sjdbGTFfile ${gtf}/Mus_musculus.GRCm38.90.gtf \
--readFilesCommand zcat \
--readFilesIn ${data}/${name}_1.fastq.gz \
--outFilterType BySJout --outFilterMultimapNmax 20 --alignSJoverhangMin 8 --alignSJDBoverhangMin 1 \
--outFilterMismatchNmax 999 --outFilterMismatchNoverLmax 0.1 --alignIntronMin 20 \
--alignIntronMax 1000000 --alignMatesGapMax 1000000 --outSAMattributes NH HI NM MD \
--outSAMtype BAM SortedByCoordinate \
--outFileNamePrefix ${out}/${name} \
