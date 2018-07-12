####replace 
here GID to replace gid
sed -i 's/GID/gid/g' myFile.gff
awk '{gsub(/1/,"0");}' file
awk '{gsub(/pattern/,"replacement")}' file

######
https://samtools.github.io/hts-specs/SAMv1.pdf
http://bioinformatics.cvr.ac.uk/blog/tag/cigar-string/
##bam to bed
bamToBed -i lane1G1_sequence.bam -split > accG1.bed
###bed to bed graph
awk '{ print $1"\t"$2"\t"$3"\t"$5 }' G2.bed > G2.bedgraph
###cpnvert bam to bigwig
bamCoverage -b lane1G3_sequence.bam -o G3.bigWig
###sort bedgraph 
sort -k1,1 -k2,2 unsorted.bedGraph > sorted.bedGraph
####track
https://davetang.org/muse/2012/03/15/visualising-rna-seq-like-data/
###split bw in forward and reverse was 
bamCoverage -p 20 --filterRNAstrand forward -b lane1G3_sequence.bam -o G3_f.m.bw
bamCoverage -p 20 --filterRNAstrand reverse -b lane1G3_sequence.bam -o G3_r.m.bw
###########gtf processing 

cat Mus_musculus.GRCm38.92.gtf | grep -v "^#" | cut -f3 | sort | uniq -c | sort -k1rn
801623 exon
 507246 CDS
 135276 transcript
  90940 five_prime_utr
  81886 three_prime_utr
  57560 start_codon
  53801 gene
  53487 stop_codon
     65 Selenocysteine
  #####
  
cat Mus_musculus.GRCm38.92.gtf |
awk 'BEGIN{OFS="\t";} $3=="exon" {print $1,$4-1,$5}' |
~/softwear/bedtools2/bin/sortBed |
~/softwear/bedtools2/bin/mergeBed -i - | gzip > gencode_v${v}_exon_merged.bed.gz



######chromosme size check from fasta file
samtools faidx genome.fa
cut -f1,2 genome.fa.fai > genome.size

### other way 
pip install pyfaidx
faidx -i chromsizes input.fa > output.chromsizes

#####separte coding and noncoding 

cat Mus_musculus.GRCm38.92.gtf |
awk 'BEGIN{OFS="\t";} $3=="exon" {print $1,$4-1,$5}' |
~/softwear/bedtools2/bin/sortBed |
~/softwear/bedtools2/bin/mergeBed -i - | gzip > gencode_v${v}_exon_merged.bed.gz


cat Mus_musculus.GRCm38.92.gtf |
awk 'BEGIN{OFS="\t";} $3=="gene" {print $1,$4-1,$5}' |
~/softwear/bedtools2/bin/sortBed |
~/softwear/bedtools2/bin/subtractBed -a stdin -b gencode_v${v}_exon_merged.bed.gz |
gzip > gencode_v${v}_intron.bed.gz
 
#let's intersect the two files
#this shouldn't produce any output
intersectBed -a gencode_v${v}_exon_merged.bed.gz -b gencode_v${v}_intron.bed.gz
####
mysql --user=genome --host=genome-mysql.cse.ucsc.edu -A -e \
        "select chrom, size from hg19.chromInfo"  > hg19.genome
####

cat Mus_musculus.GRCm38.92.gtf |
awk 'BEGIN{OFS="\t";} $3=="gene" {print $1,$4-1,$5}' |
~/softwear/bedtools2/bin/sortBed |
~/softwear/bedtools2/bin/complementBed -i stdin -g GRC38.genome |
gzip > gencode_v${v}_intergenic.bed.gz

