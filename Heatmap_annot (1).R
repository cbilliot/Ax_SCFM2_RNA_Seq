#Initial installation of required programs
#if (!requireNamespace("BiocManager", quietly = TRUE))
#  install.packages("BiocManager")

BiocManager::install("DESeq2")
BiocManager::install("biomaRt")
BiocManager::install("genefilter")
install.packages("tidyverse")
install.packages("gplots")
install.packages("RColorBrewer")
install.packages("pheatmap")

#Open required programs for the analysis

library(DESeq2)
library(ggplot2)
library( genefilter)
library(pheatmap)
library(dplyr)


cts <- read.csv(file = 'annot_Ax_LB_vs_SCFM.csv', sep = ',', header = TRUE)

#Assign gene names as row names instead of the first column of the matrix

cts <- cts %>% distinct(Sym, .keep_all=TRUE)
cts <- cts[complete.cases(cts), ]
row.names(cts) <- cts$Sym
cts$GeneID <- NULL
cts[1] <- NULL
cts$Annot <- NULL
cts$Sym <- NULL


#Run differential expression analysis
dds <- DESeqDataSetFromMatrix(countData = cts,
                              colData = coldata,
                              design = ~condition)

dds <- DESeq(dds, test = c("Wald"), betaPrior = TRUE)

nrow(dds)
dds <- dds[ rowSums(counts(dds)) > 1, ]
nrow(dds)

#Before creating a PCA plot, differential expression values must be rlog transformed to avoid only the most differentially expressed genes from dominating the analysis
#rlog or variance stabilizing transformation
vsd <- varianceStabilizingTransformation(dds, blind = TRUE)

df <- as.data.frame(colData(dds))
df <- df["condition"]

library( "genefilter" )
topVarGenes <- order( rowVars( assay(vsd) ), decreasing=TRUE )[1:35]

library("pheatmap")
pheatmap(assay(vsd)[topVarGenes,], cluster_rows=TRUE, show_rownames=TRUE,
         cluster_cols=FALSE, annotation_col=df)



