### Script 2 plot ADMXITURE ###
### Usage:
## Rscript script.R prefix_admixture_output K_max

## What you will need:

## 1. install the library called 'RColorBrewer'
## the script will load the library for you, but first you have to install it with install.packages()

## 2. ADMIXTURE outputs
## write the file name in 'admixture' without the K value and the extension 
## ie. output.3.Q -> output || admixture_file_output.10.Q -> admixture_file_output

## 2a. The admixture files should have TWO columns as 1st and 2nd column with POP and ID names: 
## ie. GBR ID1 0.99 0.01
## ie. GBR ID1 0.98 0.01 0.01 

## 3. a list of the POPS in the specific order you want to plot them
## add this list in 'neworder' (line 31)

####################################
## Here is where you load the files
## A. ADMIXTURE file
## B. neworder file
###################################

args = commandArgs(trailingOnly=TRUE)
admixture_file = args[1]
K_max = args[2]

neworder <- c('ESN','YRI','LWK','MSL','GWD',
              'GBR','FIN','IBS','TSI','CEU',
              'CHS','CHB','CDX','KHV','JPT',
              'ASW','PUR','PEL','MXL','CLM','ACB',
              'ITU','STU','BEB','GIH','PJL')


##################
## Let's start! ##
##################

library(RColorBrewer)
library(ggplot2)
library(forcats)
library(ggthemes)
library(patchwork)


pdf("ADMXITURE_plot.pdf",width = 30,height = 15)
for (run in 2:K_max) {
  
  adm <- read.table(paste0(admixture_file,".",run,".Q"))
  adm.splitted <- split(adm[,-c(1:2)],adm[,1])
  adm.reordered <- adm.splitted[neworder]
#  adm.reordered <- adm.splitted
  adm.reordered <- do.call(rbind,adm.reordered)
  
  colors <- (rainbow(run))
  
  par(mar=c(20,3,3,1))
  barplot(t(adm.reordered),col=colors,border=NA,space = 0,
          names.arg = rep("",nrow(adm.reordered)),axes = F, main = paste0("K",run),
          cex.main = 2)
  
  axis(2,line=-0.1,las=2,cex=0.6)
  newrows <- gsub (replacement = "",pattern ="\\.[0-9]*" ,x =rownames(adm.reordered))
  pops=unique(newrows)
  labels <- sapply(pops,function(X) median(which(newrows==X)))
  lines <- sapply(pops,function(X) max(which(newrows==X)))
  abline(v=lines,col="white",lwd=2)
  text(x =labels,y = -0.02,labels = names(labels),
       cex=1.5, srt=70,xpd=NA,adj = 1) }
dev.off()

