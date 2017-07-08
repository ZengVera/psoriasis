options(bitmapType="cairo")
library(metaX)

######  positive ########
para <- new("metaXpara")
pfile <- "measurement_pos.csv"
sfile <- "sample_list_pos.txt"
idres<-"identification_pos.csv"

para@outdir <- "metaX_pos"
para@prefix <- "pos"

para@sampleListFile <- sfile
para@ratioPairs <- "disease:healthy"
para <- importDataFromQI(para,file=pfile)

plsdaPara <- new("plsDAPara")
plsdaPara@scale = "pareto"
p <- metaXpipe(para,plsdaPara=plsdaPara,idres=idres,cvFilter=0.3,qcsc=1,scale="pareto",t=1,remveOutlier=TRUE,nor.method="combat",nor.order=2,pclean = TRUE,doROC=TRUE)
sessionInfo()


###### negative #########
para <- new("metaXpara")
pfile <- "measurement_neg.csv"
sfile <- "sample_list_neg.txt"
idres<-"identification_neg.csv"

para@outdir <- "metaX_neg"
para@prefix <- "neg"

para@sampleListFile <- sfile
para@ratioPairs <- "disease:healthy"
para <- importDataFromQI(para,file=pfile)

plsdaPara <- new("plsDAPara")
plsdaPara@scale = "pareto"
p <- metaXpipe(para,plsdaPara=plsdaPara,idres=idres,cvFilter=0.3,qcsc=1,scale="pareto",t=1,remveOutlier=TRUE,nor.method="combat",nor.order=2,pclean = TRUE,doROC=TRUE)
sessionInfo()

