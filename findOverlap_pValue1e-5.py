#To find the overlap between 3utrQTL and eQTL
#Zhe Cui -built on Jan 29 4:29 pm

file_3utr = "/mount/weili2/Lei/GTEx_3UTR-QTLs/Adipose-Subcutaneous.cis_eqtl.txt"
#file_3utr = "test3QTL.txt"
file_eQtl = "/home/zhec/3utr_project/Adipose_S0.00001.txt"
#file_eQtl = "testeQTL.txt"
file_overlap = "/home/zhec/overlapOfAdipose-Subcutaneous.txt"
#file_overlap = "./testoverlap.txt"
f1 = open(file_3utr, "r")
f2 = open(file_eQtl, "r")
file_3utr = f1.readlines()
file_eQtl = f2.readlines()
f1.close()
f2.close()
overlap_file = open(file_overlap, "w")
flag_overlap = 0
flag_unique = 0

for i in range(1,len(file_3utr)):
   loci=0
   whether_unique = 1
   line_file_3utr = filter(None,file_3utr[i].split('\t'))
   countletter = 0
   while line_file_3utr[0][countletter] != '_':
      countletter += 1
  # print line_file_3utr[0][3:(countletter)]
   if line_file_3utr[0][3:countletter].isdigit():
      chr1 = int(line_file_3utr[0][3:countletter])
   else:
      chr1 = line_file_3utr[0][3:countletter]
   countletter2 = countletter+1
   while line_file_3utr[0][countletter2] != '_':
      countletter2 += 1
   loci = int(line_file_3utr[0][countletter+1:countletter2])
   
   for i2 in range(len(file_eQtl)):
      loci2 = 0
      line_file_eqtl = filter(None,file_eQtl[i2].split('\t'))
  #    print line_file_eqtl	
      countletter_e = 0
      while line_file_eqtl[1][countletter_e] != '_':
         countletter_e += 1
      if line_file_eqtl[1][0:countletter_e].isdigit():
         chr2 = int(line_file_eqtl[1][0:countletter_e])
      else:
	 chr2 = line_file_eqtl[1][0:countletter_e]
      countletter_e2 = countletter_e + 1
      while line_file_eqtl[1][countletter_e2] != '_':
         countletter_e2 += 1
      loci2 = int(line_file_eqtl[1][countletter_e+1:countletter_e2])
      
      if chr1 == chr2:
         if loci == loci2:
            whether_unique = 0
            break
         else:
            whether_unique = 1
            continue
      else:
         whether_unique = 1
         continue
            
   if whether_unique == 1:
      flag_unique += 1
   else:
      flag_overlap += 1
                
         
  # if i==3 and not in file_eQtl:
  #    flag_unique += 1
   #   continue
  # if i==3 and in file_eQtl:
  #    flag_overlap += 1
    #  continue

overlap_file.write("uniqueQTL:\n")
overlap_file.write(str(flag_unique)+'\n')
overlap_file.write("overlapQTL:\n")
overlap_file.write(str(flag_overlap)+'\n')
overlap_file.close()





