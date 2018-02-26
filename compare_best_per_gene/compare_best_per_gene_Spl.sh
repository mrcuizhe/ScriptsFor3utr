#!/bin/bash
## This is a script for find the best 3utr and eqtl per gene and find the overlap and unique between them.
##Written by Zhe 2/1/2018

tissue_3utr="Spleen"
tissue_eqtl="Spleen"
temp="/home/zhec/temp3.txt"
temp2="/home/zhec/temp4.txt"
Input_3utr="/mount/weili2/Lei/GTEx_3UTR-QTLs/"$tissue_3utr".cis_eqtl.txt"
Sorted_3utr_sig="/mount/weili2/zhec/3utr/compare_best_per_gene/data/3utr.sorted."$tissue_3utr".sig.txt"
Best_3utr="/mount/weili2/zhec/3utr/compare_best_per_gene/data/3utr.best."$tissue_3utr".sig.txt"
Input_eqtl="/mount/weili2/Lei/GTEx_eQTL_SNPs/GTEx_Analysis_v7_eQTL_all_associations/"$tissue_eqtl".allpairs.txt"
Sorted_eqtl_sig="/mount/weili2/zhec/3utr/compare_best_per_gene/data/eqtl.sorted."$tissue_eqtl".sig.txt"
Best_eqtl="/mount/weili2/zhec/3utr/compare_best_per_gene/data/eqtl.best."$tissue_eqtl".sig.txt"

date >$Overlap
 > $Sorted_3utr_sig
 > $Sorted_eqtl.sig
awk '$5<=0.00001' $Input_3utr | cut -f 1,2,5 |sort -k 2,2 -k 3g,3 > $Sorted_3utr_sig &
awk '$7<=0.00001' $Input_eqtl | cut -f 1,2,7 |cut -d"_" -f1,2,3,4 > $temp &
awk '$7<=0.00001' $Input_eqtl | cut -f 1,2,7 |cut -d"	" -f3 > $temp2 &
wait
paste $temp $temp2 |awk '{$2="chr"$2; print}'|sort -k 1,1 -k 3g,3 > $Sorted_eqtl_sig &
wait
rm $temp
rm $temp2
python /home/zhec/3utr_project/ScriptsFor3utr/compare_best_per_gene/find_best.py $Sorted_3utr_sig $Sorted_eqtl_sig $Best_3utr $Best_eqtl &
wait
rm $Sorted_3utr_sig
rm $Sorted_eqtl_sig
rm $temp
rm $temp2


