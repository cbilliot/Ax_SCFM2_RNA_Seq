#Install packages if needed

install.packages("knitr")
BiocManager::install("clusterProfiler")

#load packages needed

library(clusterProfiler)
library(tidyverse)

search_kegg_organism('axo', by='kegg_code')

geneList <- read.csv("annot_Ax_LB_vs_SCFM.csv") %>% pull(log2FoldChange)
names(geneList) <- read.csv("annot_Ax_LB_vs_SCFM.csv") %>% pull(GeneID)
kk <- enrichKEGG(gene         = geneList,
                 organism     = 'axo',
                 pvalueCutoff = 1)

table <- kk@result

write.csv(table, "KEGG_Enrich.csv", row.names = FALSE)


geneList <- read.csv("annot_Ax_LB_vs_SCFM.csv") %>% pull(log2FoldChange)
names(geneList) <- read.csv("annot_Ax_LB_vs_SCFM.csv") %>% pull(GeneID)
gene <- names(geneList)[(geneList) > 0]
kk <- enrichKEGG(gene         = gene,
                 organism     = 'axo',
                 pvalueCutoff = 1)

table <- kk@result

write.csv(table, "KEGG_Enrich_up.csv", row.names = FALSE)

geneList <- read.csv("annot_Ax_LB_vs_SCFM.csv") %>% pull(log2FoldChange)
names(geneList) <- read.csv("annot_Ax_LB_vs_SCFM.csv") %>% pull(GeneID)
gene <- names(geneList)[(geneList) < 0]
kk <- enrichKEGG(gene         = gene,
                 organism     = 'axo',
                 pvalueCutoff = 1)

table <- kk@result

write.csv(table, "KEGG_Enrich_down.csv", row.names = FALSE)



#write.csv(table, "KEGG_Enrich_up.csv", row.names = FALSE)

