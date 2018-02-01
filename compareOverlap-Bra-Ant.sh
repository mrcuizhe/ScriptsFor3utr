#!/bin/bash
## This is a script for finding the overlap3utrQTL and the unique3utrQTL
##Written by Zhe 01/31/2018

Input_3utr="/mount/weili2/Lei/GTEx_3UTR-QTLs/Brain-Anteriorcingulatecortex_BA24.cis_eqtl.txt"
Output_3utr_sig="/home/zhec/3utr_project/data/3utr.Brain-Anteriorcingulatecortex_BA24.cis.sig.txt"
Input_eqtl="/mount/weili2/Lei/GTEx_eQTL_SNPs/GTEx_Analysis_v7_eQTL_all_associations/Brain_Anterior_cingulate_cortex_BA24.allpairs.txt"
Output_eqtl_sig="/home/zhec/3utr_project/data/eqtl.Brain_Anterior_cingulate_cortex_BA24.allpairs.sig.txt"
Overlap="/home/zhec/3utr_project/result/Brain_Anterior_cingulate_cortex_BA24.txt"

date >$Overlap
 > $Output_3utr_sig
 > $Output_eqtl.sig
awk '$5<=0.00001' $Input_3utr | cut -f1 |sort|uniq > $Output_3utr_sig &
awk '$7<=0.00001' $Input_eqtl | cut -f2 | cut -d"_" -f1,2,3,4 |while read a; do echo -e "chr${a}";done|sort|uniq > $Output_eqtl_sig &
wait
total=$(wc -l < $Output_3utr_sig)
echo "Overlap:" >> $Overlap
cat $Output_3utr_sig $Output_eqtl_sig |sort|uniq -d |wc -l >> $Overlap &
wait
overlap=$(tail -1 < $Overlap)

echo "Unique" >> $Overlap
total=`echo "$total $overlap"|awk '{printf("%g",$1-$2)}'`
echo $total >> $Overlap


