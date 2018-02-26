#!/bin/sh
address="/mount/weili2/zhec/3utr/tissuebytissuesimilarity/data/1e-5/3utr"
for file in /mount/weili2/Lei/GTEx_3UTR-QTLs/*
do
resFile=`echo "$file" | awk -F "/" '{print $NF}'`
resFile2=`echo "$resFile" | awk -F "." '{print $1}'`
awk '$5<=0.00001' $file | cut -f1,2,5 > $address/3utr."$resFile2".txt &
wait
echo "The cut of $resFile2 is finished"
done
i=0
#for file in $address/*
#do
#resFile=`echo "$file" | awk -F "/" '{print $NF}'`
#resFile2=`echo "$resFile" | awk -F "." '{print $2}'`
#echo -n $resFile2" " >> $pianswer
#done
#echo -n -e "\n" >>$pianswer
for file in $address/*
do
resFile=`echo "$file" | awk -F "/" '{print $NF}'`
resFile2=`echo "$resFile" | awk -F "." '{print $2}'`
pianswer="/mount/weili2/zhec/3utr/tissuebytissuesimilarity/result/specific_3utr/"$resFile2"_3utr_pair_1e-5.txt"
echo "The specific pair in $resFile2 :"> $pianswer
let "i += 1"
cut -f1,2 $file> /mount/weili2/zhec/temp3.txt &
wait
#echo $resFile
#echo $pianswer
	if test -f $file
        then
		>/mount/weili2/zhec/temp4.txt
		for file2 in $address/*
		do	
			resFile3=`echo "$file2" | awk -F "/" '{print $NF}'`
			resFile4=`echo "$resFile3" | awk -F "." '{print $2}'`
			if [ $resFile2 = $resFile4 ]
			then
			#	echo ""$resFile4" is continued"
				continue
			fi
			cut -f1,2 $file2 >>/mount/weili2/zhec/temp4.txt &
			wait
		done
		awk 'NR==FNR{a[$0]=1}NR>FNR{if(a[$0]!=1)print}' /mount/weili2/zhec/temp4.txt /mount/weili2/zhec/temp3.txt > /mount/weili2/zhec/temp5.txt &
		wait
		cat /mount/weili2/zhec/temp5.txt|while read a;do grep "$a" /mount/weili2/Lei/GTEx_3UTR-QTLs/"$resFile2".cis_eqtl.txt;done >$pianswer &
		wait
		echo temp5 num is $(wc -l </mount/weili2/zhec/temp5.txt)
		echo $resFile2 num is $(wc -l <$pianswer)
		rm /mount/weili2/zhec/temp4.txt
		rm /mount/weili2/zhec/temp5.txt
		echo "No."$i":"$resFile2" is finished"
	fi
rm /mount/weili2/zhec/temp3.txt
done

