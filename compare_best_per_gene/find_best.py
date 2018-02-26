import sys 
#print sys.argv[1],sys.argv[2],sys.argv[3],sys.argv[4]
address_3utr=sys.argv[1]
address_eqtl=sys.argv[2]
best_address_3utr=sys.argv[3]
best_address_eqtl=sys.argv[4]
file1 = open(address_3utr,"r")
file2 = open(address_eqtl,"r")
file_3utr = file1.readlines()
file_eqtl = file2.readlines()
file1.close()
file2.close()
best_3utr = open(best_address_3utr,"w")
best_eqtl = open(best_address_eqtl,"w")

#Start to get the best 3utr per gene
i=0
length=len(file_3utr)
while i<length:
	line_file_3utr = filter(None,file_3utr[i].split('\t'))
#	print line_file_3utr
	best_3utr.write(line_file_3utr[1]+" "+line_file_3utr[0]+" "+line_file_3utr[2])
	if i+1 ==length:
		break
	line_file_3utr_next = filter(None,file_3utr[i+1].split('\t'))
	if line_file_3utr[1] == line_file_3utr_next[1]:
#		print line_file_3utr[1]
		if line_file_3utr[2] == line_file_3utr_next[2]:
			i += 1
			continue
		else:
			same=2
			for ii in range(i+2,length):
				line_file_3utr_next2 = filter(None,file_3utr[ii].split('\t'))
				if line_file_3utr[1] == line_file_3utr_next2[1]:
					same += 1
				else:
					break
			i=i+same-1
	i += 1
#End to get the best 3utr per gene
print "finish the part of 3utr"
#Start to get the best eqtl per gene
i2=0
length2=len(file_eqtl)
while i2<length2:
	line_eqtl_file = filter(None,file_eqtl[i2].split(' '))
	#print line_eqtl_file
	best_eqtl.write(line_eqtl_file[0]+" "+line_eqtl_file[1]+" "+line_eqtl_file[2])
	if i2+1 ==length2:
		break
	line_eqtl_file_next = filter(None,file_eqtl[i2+1].split(' '))
	if line_eqtl_file[0] == line_eqtl_file_next[0]:
		if line_eqtl_file[2] == line_eqtl_file_next[2]:
			i2 += 1
			continue
		else:
			same=2
			for ii in range(i2+2,length2):
				line_eqtl_file_next2 = filter(None,file_eqtl[ii].split(' '))
				if line_eqtl_file_next2[0] == line_eqtl_file[0]:
					same =same+1
				else:
					break
			i2=i2+same-1
	i2 += 1
#End to get the best eqtl per gene
best_3utr.close()
best_eqtl.close()
print "finish the part of eqtl"
print "finish the part of selecting best 3utr/eqtl per gene"
