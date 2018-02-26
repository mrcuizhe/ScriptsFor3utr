library(biomaRt)
args<-commandArgs()
data_raw <- read.table(args[6],stringsAsFactor=FALSE)
mart <- useMart(biomart ='ensembl', dataset ='hsapiens_gene_ensembl')
bm.query <- getBM(values=data_raw$V1,attributes=c("ensembl_gene_id","external_gene_name"),filters=c("ensembl_gene_id"),mart=mart)
genes <- list(ids=data_raw$V1,names=bm.query[match(data_raw$V1, bm.query$ensembl_gene_id),]$external_gene_name)
#temp solution: remove the ensemble id that don’t have gene names length(which(is.na(genes$names)==“TRUE”))
#if (length(which(is.na(genes$names)=="TRUE")) != 0){
#	  data_raw <- data_raw[-which(is.na(genes$names)=="TRUE"),]
#  bm.query <- getBM(values=data_raw$V1,attributes=c("ensembl_gene_id","external_gene_name"),filters=c("ensembl_gene_id"),mart=mart)
#    genes <- list(ids=data_raw$V1,names=bm.query[match(data_raw$V1, bm.query$ensembl_gene_id),]$external_gene_name)
#}
data_raw$V1 <- genes$names
data_raw$V1[which(is.na(genes$names)=="TRUE")] <- genes$ids[which(is.na(genes$names)=="TRUE")]
data_raw <- write.table(data_raw,args[7],quote=FALSE,row.names=FALSE,col.names=FALSE)
