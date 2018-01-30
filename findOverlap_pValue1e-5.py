#To find the overlap between 3utrQTL and eQTL
#Zhe Cui -built on Jan 29 4:29 pm
file_3utr = "/mount/weili2/Lei/GTEx_3UTR-QTLs/Adipose-Subcutaneous.cis_eqtl.txt"
file_eQtl = "/mount/weili2/Lei/GTEx_eQTL_SNPs/GTEx_Analysis_v7_eQTL_all_associations/Adipose_Subcutaneous.allpairs.txt"
file_overlap = "/home/zhec/overlapOfAdipose-Subcutaneous.txt"
f1 = open(file_3utr, "r")
f2 = open(file_eQtl, "r")
file_3utr = f1.readlines()
file_eQtl = f2.readlines()
f1.close()
f2.close()
overlap_file = open(file_overlap, "w")
flag_overlap = 0
flag_unique = 0

for i in file_3utr:
   if i==3 and not in file_eQtl:
      flag_unique += 1
      continue
   if i==3 and in file_eQtl:
      flag_overlap += 1
      continue

overlap_file.write("uniqueQTL：\n")
overlap_file.write(flag_unique)
overlap_file.write("overlapQTL：\n")
overlap_file.write(flag_overlap)
overlap_file.close()





