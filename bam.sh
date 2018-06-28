
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
