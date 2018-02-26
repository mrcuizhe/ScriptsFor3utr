import sys
address_3utr=sys.argv[1]
address_eqtl=sys.argv[2]
overlap_address=sys.argv[3]
unique_3utr_address=sys.argv[4]
unique_eqtl_address=sys.argv[5]
file1=open(address_3utr,"r")
file2=open(address_eqtl,"r")
file_3utr=file1.readlines()
file_eqtl=file2.readlines()
file1.close()
file2.close()
overlap=open(overlap_address,"w")
unique_3utr=open(unique_3utr_address,"r+")
unique_3utr.read()
unique_eqtl=open(unique_eqtl_address,"r+")
unique_eqtl.read()

#start to compare
i=0
length=len(file_3utr)
i2=0
length2=len(file_eqtl)
while i<length:
	line_file_3utr = filter(None,file_3utr[i].split(' '))
	temp_3utr=[]
	temp_3utr.append(line_file_3utr)
	ii=i+1
	while ii<length:
		line_file_3utr_temp = filter(None,file_3utr[ii].split(' '))
#		print line_file_3utr,line_file_3utr_temp
		if line_file_3utr_temp[1] == line_file_3utr[1]:
			temp_3utr.append(line_file_3utr_temp)
			ii += 1
		else:
			break
	ii2=i2
	temp_eqtl=[]
	while ii2<length2:
		line_file_eqtl = filter(None,file_eqtl[ii2].split(' '))
		#print line_file_eqtl
		if line_file_3utr[1] == line_file_eqtl[1]:
			temp_eqtl.append(line_file_eqtl)
			ii2 += 1
		else:
			break
	for iii in range(ii-i):
		if temp_3utr[iii] == [" "]:
			continue
		temp_3utr_1 = filter(None,temp_3utr[iii][0].split('|'))
		activeNA = "T"
		NA = "F"
		NAlocation =0
		for iii2 in range(ii2-i2):
			if temp_eqtl[iii2][0][0:4] == "ENSG":
				NA ="T"
				NAlocation = iii2
			if temp_eqtl[iii2] == [" "]:
				continue
			if temp_3utr_1[1] == temp_eqtl[iii2][0]:
	#			print temp_3utr[iii],temp_eqtl[iii2]
				overlap.write(temp_3utr[iii][0]+" "+temp_3utr[iii][1]+" "+temp_3utr[iii][2][:-1]+" "+temp_eqtl[iii2][0]+" "+temp_eqtl[iii2][1]+" "+temp_eqtl[iii2][2])
				temp_eqtl[iii2] =[" "]
				activeNA = "F"
			if iii2+1 == ii2-i2:
				if activeNA == "T" and NA == "T":
					overlap.write(temp_3utr[iii][0]+" "+temp_3utr[iii][1]+" "+temp_3utr[iii][2][:-1]+" "+temp_eqtl[iii2][0]+" "+temp_eqtl[iii2][1]+" "+temp_eqtl[iii2][2])
					temp_3utr[iii] =[" "]
				if activeNA == "F":
					temp_3utr[iii] =[" "]
#	print temp_3utr,"temp_3utr"
	for iii in range(ii-i):
#		print temp_3utr[iii], iii
		if temp_3utr[iii] == [" "]:
			continue
		unique_3utr.write(temp_3utr[iii][0]+" "+temp_3utr[iii][1]+" "+temp_3utr[iii][2])
#	print temp_eqtl,"temp_eqtl"
	for iii2 in range(ii2-i2):
		if temp_eqtl[iii2] == [" "]:
			continue
		if temp_eqtl[iii2][0][0:4] == "ENSG":
			continue
		unique_eqtl.write(temp_eqtl[iii2][0]+" "+temp_eqtl[iii2][1]+" "+temp_eqtl[iii2][2])
	i2=ii2		
	i =ii
overlap.close()
unique_3utr.close()
unique_eqtl.close()








		
