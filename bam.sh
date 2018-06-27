
##bam to bed
bamToBed -i lane1G1_sequence.bam -split > accG1.bed
###bed to bed graph
awk '{ print $1"\t"$2"\t"$3"\t"$5 }' G2.bed > G2.bedgraph
###cpnvert bam to bigwig
bamCoverage -b lane1G3_sequence.bam -o G3.bigWig
###sort bedgraph 
sort -k1,1 -k2,2 unsorted.bedGraph > sorted.bedGraph
