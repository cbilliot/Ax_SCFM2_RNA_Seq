#Initial installation of required programs
#if (!requireNamespace("BiocManager", quietly = TRUE))
#  install.packages("BiocManager")

#BiocManager::install("DESeq2")

#install.packages("tidyverse")

#Open required programs for the analysis

library(DESeq2)
library(ggplot2)

#Run differential expression analysis
coldata <- read.table(file = 'coldata.txt', sep = '\t', header = TRUE)

cts <- read.table(file = 'Ax_counts.txt', sep = '\t', header = TRUE)

row.names(cts) <- cts$GeneID
cts[1] <- NULL

dds <- DESeqDataSetFromMatrix(countData = cts,
                              colData = coldata,
                              design = ~condition)
dds <- DESeq(dds)

#Before creating a PCA plot, differential expression values must be rlog transformed to avoid only the most differentially expressed genes from dominating the analysis
#rlog or variance stabilizing transformation
vsd <- varianceStabilizingTransformation(dds, blind = TRUE)
rld <- rlog( dds )

#View to check for successful transformation
head( assay(rld) )
head(assay(vsd), 3)


#PCA plot

pcaData <- plotPCA(vsd, intgroup=c("condition", "SampleID"), returnData=TRUE)
percentVar <- round(100 * attr(pcaData, "percentVar"))
ggplot(pcaData, aes(PC1, PC2, color=condition)) +
  geom_point(size=2) +
  xlab(paste0("PC1: ",percentVar[1],"% variance")) +
  ylab(paste0("PC2: ",percentVar[2],"% variance")) + 
  coord_fixed() +
  stat_ellipse(geom = "polygon", alpha = 1/8, aes(fill=condition)) +
  xlim(-30,30) +
  ylim(-20,20) +
  scale_color_manual(values = c("mediumvioletred","midnightblue","springgreen4")) +
  theme_light()