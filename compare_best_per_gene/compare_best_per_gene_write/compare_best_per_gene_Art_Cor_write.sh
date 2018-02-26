#!/bin/bash
##This is a script to write the overlap and unique loci from best 3utr and eqtl.
##Wrutten by Zhe on 2/4/2018

tissue_3utr="Artery-Coronary"
tissue_eqtl="Artery_Coronary"
temp="/home/zhec/temp.txt"
temp2="/home/zhec/temp2.txt"
temp3="/mount/weili2/zhec/3utr/compare_best_per_gene/result/temp3.txt"
temp4="/home/zhec/temp4.txt"
temp5="/home/zhec/temp5.txt"
temp6="/mount/weili2/zhec/3utr/compare_best_per_gene/result/temp6.txt"
Input_3utr="/mount/weili2/zhec/3utr/compare_best_per_gene/data/3utr.best."$tissue_3utr".sig.txt"
Input_eqtl="/mount/weili2/zhec/3utr/compare_best_per_gene/data/eqtl.best."$tissue_eqtl".sig.txt"
Overlap="/mount/weili2/zhec/3utr/compare_best_per_gene/result/"$tissue_eqtl".overlap.txt"
Unique_3utr="/mount/weili2/zhec/3utr/compare_best_per_gene/result/"$tissue_eqtl".3utr.unique.txt"
Unique_eqtl="/mount/weili2/zhec/3utr/compare_best_per_gene/result/"$tissue_eqtl".eqtl.unique.txt"
cut -d" " -f 2 $Input_3utr |sort|uniq > $temp &
cut -d" " -f 2 $Input_eqtl |sort|uniq > $temp2 &
wait
cp $Input_3utr $Unique_3utr
cp $Input_eqtl $temp5
cat $temp $temp2 |sort|uniq -d |while read a; do sed -n '/'"$a"'/p' $Unique_3utr ;done > $temp3 &
cat $temp $temp2 |sort|uniq -d |while read a; do sed -n '/'"$a"'/p' $temp5;done > $temp4 &
wait
cat $temp $temp2 |sort|uniq -d |while read a; do sed -i '/'"$a"'/d' $Unique_3utr ;done &
cat $temp $temp2 |sort|uniq -d |while read a; do sed -i '/'"$a"'/d' $temp5 ;done &
wait
cut -d" " -f1 $temp4|cut -d"." -f1 > $temp &
cut -d" " -f2,3 $temp4 >$temp2 &
wait
paste $temp $temp2 > $temp4
cut -d" " -f1 $temp5|cut -d"." -f1 > $temp &
cut -d" " -f2,3 $temp5 >$temp2 &
wait
paste $temp $temp2 > $temp5

module load R/3.4.2
Rscript /home/zhec/3utr_project/ScriptsFor3utr/change_gene_name.R $temp5 $Unique_eqtl &
Rscript /home/zhec/3utr_project/ScriptsFor3utr/change_gene_name.R $temp4 $temp6 &
wait
python ./merge.py $temp3 $temp6 $Overlap $Unique_3utr $Unique_eqtl &
wait
rm $temp
rm $temp3
rm $temp2
rm $temp4
rm $temp5
rm $temp6



