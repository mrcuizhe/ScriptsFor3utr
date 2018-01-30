#To find the overlap between 3utrQTL and eQTL
#Zhe Cui -built on Jan 29 4:29 pm

#file_3utr = "/mount/weili2/Lei/GTEx_3UTR-QTLs/Adipose-Subcutaneous.cis_eqtl.txt"
file_3utr = "test3QTL.txt"
#file_eQtl = "/mount/weili2/Lei/GTEx_eQTL_SNPs/GTEx_Analysis_v7_eQTL_all_associations/Adipose_Subcutaneous.allpairs.txt"
file_eQtl = "testeQTL.txt"
#file_overlap = "/home/zhec/overlapOfAdipose-Subcutaneous.txt"
file_overlap = "./testoverlap.txt"
f1 = open(file_3utr, "r")
f2 = open(file_eQtl, "r")
file_3utr = f1.readlines()
file_eQtl = f2.readlines()
f1.close()
f2.close()
overlap_file = open(file_overlap, "w")
flag_overlap = 0
flag_unique = 0

for i in range(len(file_3utr)):
   loci=[]
   chr1=0
   whether_unique = 1
   for j in range(len(file_3utr[i])):
      if file_3utr[i][j] == '_' and len(loci) == 0:
         iii = 1
         while file_3utr[i][j-iii] != 'r':
            iii += 1
         for iiii in range(1,iii):
            chr1 = chr1 + int(file_3utr[i][j-iiii])*(10**(iiii-1))
         ii = 1
         while file_3utr[i][j+ii] != '_':
            loci.append(file_3utr[i][j+ii])
            ii += 1
      if len(loci) != 0:
         break
   if len(loci) != 0:
#      print loci,'\n'
#      print whether_unique
      for i2 in range(len(file_eQtl)):
         chr2 =0
         #Filter Start
#         filtered_eQtl = filter(None,file_eQtl[i].split(' '))
#         pValue = float(filtered_eQtl[-3])
#         if pValue > 0.00001:
#            continue
#         else:
         #Filter End
         for j2 in range(len(file_eQtl[i2])):
            if file_eQtl[i2][j2] == '_':
               iii2 = 1
               while file_eQtl[i2][j2-iii2] != ' ':
               # print file_eQtl[i][j-iii],'\n'
                  iii2 += 1
               #print str('iii= '),iii
               for iiii2 in range(1,iii2):
                  chr2 = chr2 + int(file_eQtl[i2][j2-iiii2])*(10**(iiii2-1))
#               print chr1,chr2
               if chr1 == chr2:
                  ii2 = 1
                  while ii2 <= len(loci):
#                       print loci[ii-1],file_eQtl[i][j+ii]
                     if(file_eQtl[i2][j2+ii2] == loci[ii2-1]):
                        ii2 += 1
                        whether_unique = 0
                     else:
                        whether_unique = 1
                        break
                  break
               else:
                  whether_unique = 1
                  break
         if whether_unique == 0:
            break
#      print whether_unique
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





