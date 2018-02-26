#!/bin/sh
i=0
j=0
address="/mount/weili2/zhec/3utr/compareOverlap_pvalue1e-5/data/eqtl"
pianswer="/mount/weili2/zhec/3utr/tissuebytissuesimilarity/result/matrix.txt"
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
#echo $resFile
#echo $pianswer
	if test -f $file
        then
		let "j=1"
		for file2 in $address/*
		do	
			totaldiscover=$(wc -l <$file)
			echo "totaldiscover=$totaldiscover"
			overlapnum=$(cat $file $file2 |sort|uniq -d |wc -l &)
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
