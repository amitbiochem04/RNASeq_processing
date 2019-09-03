#!/bin/bash
#MSUB -e ./hisat.stderr.%j            # stderr file
#MSUB -o ./hisat.stdout.%j            # stdout file
#MSUB -N hisat_run                  # my job's name in the queue
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
gtf=/home/hd/hd_hd/hd_lo149/genome/ct_genome_new_ref
out=/home/hd/hd_hd/hd_lo149/alignment
data=/home/hd/hd_hd/hd_lo149/data/ct

#name=$1
##specify the location
#gtf=/home/bq_asingh/genome/hisat_genome/chaetomium
#data=/home/bq_asingh/chaetomium/rawdata
#out=/home/bq_asingh/chaetomium/hisat_alignment
##first build genome hisat index or download from igenome portal

#hisat2-build Chaetomium_thermophilum.toplevel.fa chaetomium_hisat_index
#extract_splice_sites.py

##get exon 
#hisat2_extract_exons.py chaetomium.gtf > exon.txt
##get splice site
#hisat2_extract_splice_sites.py chaetomium.gtf > splicesites.txt
hisat2 -p 8 -x ${gtf}/chaetomium_hisat_index --max-intronlen 2000 --dta --rna-strandness F -U ${data}/${name}.txt.gz | samtools view -Sb - > ${out}/${name}.bam
