#!/bin/sh
i=0
j=0
address="/mount/weili2/zhec/3utr/compare_best_per_gene/data/3utr"
pianswer="/mount/weili2/zhec/3utr/tissuebytissuesimilarity/result/matrix_best_3utr.txt"
temp="/home/zhec/temp.txt"
temp2="/home/zhec/temp2.txt"
> $pianswer
for file in $address/*
do
resFile=`echo "$file" | awk -F "/" '{print $NF}'`
resFile2=`echo "$resFile" | awk -F "." '{print $3}'`
echo -n $resFile2" " >> $pianswer
done
echo -n -e "\n" >>$pianswer
for file in $address/*
do
resFile=`echo "$file" | awk -F "/" '{print $NF}'`
resFile2=`echo "$resFile" | awk -F "." '{print $3}'`
echo -n $resFile2" " >>$pianswer
let "i += 1"
#echo $resFile
#echo $pianswer
cut -d" " -f2 $file|sort|uniq >$temp &
wait
	if test -f $file
        then
		let "j=1"
		for file2 in $address/*
		do	
			cut -d " " -f2 $file2 |sort|uniq >$temp2 &
			wait
			totaldiscover=$(wc -l <$temp)
			echo "totaldiscover=$totaldiscover"
			overlapnum=$(cat $temp $temp2 |sort|uniq -d |wc -l &)
			wait
			echo "overlapnum=$overlapnum"
			pi=`echo "$totaldiscover $overlapnum"|awk '{printf("%g",$2/$1)}'`
			echo "pitotaldiscover=$pi"
			echo -n $pi" " >> $pianswer
			echo "No.$i.$j is finished"
			let "j += 1"
		done
		echo -n -e "\n" >>$pianswer
		echo "No.$i is finished"
	fi
done

rm $temp
rm $temp2
