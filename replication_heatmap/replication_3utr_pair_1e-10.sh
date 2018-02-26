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
j=0
pianswer="/mount/weili2/zhec/3utr/tissuebytissuesimilarity/result/matrix_3utr_pair_1e-10.txt"
> $pianswer
for file in $address/*
do
resFile=`echo "$file" | awk -F "/" '{print $NF}'`
resFile2=`echo "$resFile" | awk -F "." '{print $2}'`
echo -n $resFile2" " >> $pianswer
done
echo -n -e "\n" >>$pianswer
for file in $address/*
do
resFile=`echo "$file" | awk -F "/" '{print $NF}'`
resFile2=`echo "$resFile" | awk -F "." '{print $2}'`
echo -n $resFile2" " >>$pianswer
let "i += 1"
awk '$3<=0.0000000001' $file |cut -f1,2 > /mount/weili2/zhec/temp.txt &
#echo $resFile
#echo $pianswer
	if test -f $file
        then
		let "j=1"
		for file2 in $address/*
		do	
			resFile3=`echo "$file2" | awk -F "/" '{print $NF}'`
			resFile4=`echo "$resFile3" | awk -F "." '{print $2}'`
			cut -f1,2 $file2 >/mount/weili2/zhec/temp2.txt &
			wait
			totaldiscover=$(wc -l < /mount/weili2/zhec/temp.txt)
			echo "totaldiscover=$totaldiscover"
			overlapnum=$(cat /mount/weili2/zhec/temp.txt /mount/weili2/zhec/temp2.txt |sort|uniq -d |wc -l &)
			wait
			echo "overlapnum=$overlapnum"
			pi=`echo "$totaldiscover $overlapnum"|awk '{printf("%g",$2/$1)}'`
			echo "pitotaldiscover=$pi"
			echo -n $pi" " >> $pianswer
			echo "No.$i.$j is finished"
			let "j += 1"
			rm /mount/weili2/zhec/temp2.txt 
		done
		echo -n -e "\n" >>$pianswer
		echo "No.$i is finished"
	fi
rm /mount/weili2/zhec/temp.txt
done

