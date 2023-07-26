#Initial installation of required programs (if doing this for the first time)
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("genefilter")
install.packages("tidyverse")
install.packages("gplots")
install.packages("RColorBrewer")
install.packages("pheatmap")

#Open required programs for the analysis
library(DESeq2)
library(ggplot2)

#Read in gene counts and the reference file to assign groups

coldata <- read.table(file = 'coldata.txt', sep = '\t', header = TRUE)
cts <- read.table(file = 'Ax_counts.txt', sep = '\t', header = TRUE)

#Assign gene names as row names instead of the first column of the matrix
row.names(cts) <- cts$GeneID
cts[1] <- NULL

#Run differential expression analysis (make sure cts has the same number of columns as coldata does rows)
dds <- DESeqDataSetFromMatrix(countData = cts,
                              colData = coldata,
                              design = ~condition)

dds <- DESeq(dds, test = c("Wald"), betaPrior = TRUE)

nrow(dds)
dds <- dds[ rowSums(counts(dds)) > 1, ]
nrow(dds)

#Write results into a data table that can be opened in excel
res <- results( dds, contrast = c("condition", "SCFM", "LB") )

write.csv( as.data.frame(res), file="Ax_SCFM_vs_LB.csv" )

annot <- read.delim("Ax_NH44784_genome.txt", header = F, sep = "", col.names = c("GeneID", "Annot"))
NH44784 <- read.csv("Ax_SCFM_vs_LB.csv")
NH44784 <- merge(NH444784, annot, by = "GeneID")
write.csv( as.data.frame(NH44784), file="annot_Ax_SCFM_vs_LB.csv" )

#If you want to rewrite files with only significantly altered genes present
#sum( res$padj < 0.05, na.rm=TRUE )
#resSig <- res[ which(res$padj < 0.05 ), ]
#write.csv( as.data.frame(resSig), file="bacterial_frd1_dual_sig.csv" )
