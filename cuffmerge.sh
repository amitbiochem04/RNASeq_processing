#!/bin/bash
#MSUB -e ./cuffmerge.stderr.%j            # stderr file
#MSUB -o ./cuffmerge.stdout.%j            # stdout file
#MSUB -N cuffmerge_run                  # my job's name in the queue
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
out=/home/hd/hd_hd/hd_lo149
data=/home/hd/hd_hd/hd_lo149/hist_stringtie
gtf=/home/hd/hd_hd/hd_lo149/genome/ct_genome_new_ref

#cuffmerge -p 8 \
#-g ${gtf}/chaetomium.gtf \
#-s ${gtf}/Chaetomium_thermophilum.toplevel.fa  \
#-o /home/bq_asingh/chaetomium/merged_out \
#/home/bq_asingh/chaetomium/assembly_GTF_list.txt

#stringtie --merge -p 16 -G ${gtf}/Chaetomium_thermophilum_var_thermophilum_dsm_1495_gca_000221225.CTHT_3.0.41.gtf -o ${out}/stringtie_merged.gtf ${out}/assembly_GTF_list.txt
#stringtie --merge -p 16 -G ${gtf}/chaetomium.gtf -o ${out}/stringtie_merged.gtf ${out}/assembly_GTF_list.txt
#stringtie --merge -p 16 -o ${out}/stringtie_merged.gtf ${out}/assembly_GTF_list.txt

#cuffmerge -g ${gtf}/genes.gtf [options]* <assembly_GTF_list.txt> -o ${out}

gffcompare -o gffcomp_with_out_gtf -i ${out}/assembly_GTF_list.txt

gffcompare -r ${gtf}/chaetomium.gtf -G -o gffcomp_with_gtf -i ${out}/assembly_GTF_list.txt

###########assembbly_GTF_list.txt looks like below
~/hist_stringtie/lane1G1_sequence.gtf
~/hist_stringtie/lane1G2_sequence.gtf
~/hist_stringtie/lane1G3_sequence.gtf
