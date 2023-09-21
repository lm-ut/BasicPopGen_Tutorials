## This script plots PCA results 
## Usage 
## Rscript script.R file_path.pca.evec

library(ggplot2)

#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

pca_standard_header = c("IND","PC1","PC2","PC3",
                       "PC4","PC5","PC6","PC7",
                       "PC8","PC9","PC10","CC")
pca_file = args[1]

pca = read.table(pca_file, col.names = pca_standard_header )
pop_names <- gsub(":.*$", "", pca$IND)

pca["POP"] = pop_names

##############
## ALL POP ###
##############

g = ggplot(data = pca, aes(x = PC1, y=PC2), colour = factor(POP)) +
  geom_point(aes(color = POP), size =4) +
  scale_color_discrete(l = 80, c = 150) +
  #theme_bw()+
  NULL 
pdf_name = paste0(pca_file,"_PCA_Pops.pdf")
ggsave(pdf_name, width = 25, height = 15)


#################
## AREA Labels ##
#################

pca_area = pca

for (row in 1:nrow(pca_area)) {
  if (pca_area$POP[row] == 'GBR' || pca_area$POP[row] == 'FIN' || pca_area$POP[row] == 'IBS' || pca_area$POP[row] == 'TSI' || pca_area$POP[row] == 'CEU') {
    pca_area$Area[row] = "EUR"
  } else if (pca_area$POP[row] == 'ESN' || pca_area$POP[row] == 'YRI' || pca_area$POP[row] == 'LWK' || pca_area$POP[row] == 'MSL' || pca_area$POP[row] == 'GWD') {
    pca_area$Area[row] = "AFR"
  } else if (pca_area$POP[row] == 'CHS' || pca_area$POP[row] == 'CHB' || pca_area$POP[row] == 'CDX' || pca_area$POP[row] == 'KHV' || pca_area$POP[row] == 'JPT') {
    pca_area$Area[row] = "ASN"
  } else if (pca_area$POP[row] == 'ASW' || pca_area$POP[row] == 'PUR' || pca_area$POP[row] == 'PEL' || pca_area$POP[row] == 'MXL' || pca_area$POP[row] == 'CLM' || pca_area$POP[row] == 'ACB') {
    pca_area$Area[row] = "AME"
  } else if (pca_area$POP[row] == 'ITU' || pca_area$POP[row] == 'STU' || pca_area$POP[row] == 'BEB' || pca_area$POP[row] == 'GIH' || pca_area$POP[row] == 'PJL') {
    pca_area$Area[row] = "SAS"
  } else {
    pca_area$Area[row] = "Outlier" 
  }
}
    
colours_pca = c("#2fff26","#ed5565","#ffbf00",
                "#016fd9","#55d6e1","#ffc1c1","#7b007b")

p = ggplot(data = pca_area, aes(x = PC1, y=PC2, colour = factor(pca$Area))) +
  geom_point(aes(colour = Area), alpha = 0.7, size =4) +
  ggtitle(pca_file) +
  scale_colour_manual(name = "Populations", values=colours_pca, aesthetics = c("colour")) +
  #theme_bw()+
  NULL 
pdf_name = paste0(pca_file,"_PCA_Areas.pdf")
ggsave(pdf_name, width = 25, height = 15)
