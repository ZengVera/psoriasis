library(metaX)
library(dplyr)
library(reshape2)

samples<-read.table("sample.txt",header=F)[,1] # choose the samples exist both in positve and negative mode after outliers exclusion from PCA
mz<-read.table("Features.txt",header=T)[,2]

posPara<-readRDS("pos-result.rds")
negPara<-readRDS("neg-result.rds")
para<-negPara
para@peaksData<-rbind(para@peaksData,posPara@peaksData)
para@peaksData$sample<-substr(para@peaksData$sample,1,10)
para@peaksData<-para@peaksData %>% filter(sample %in% samples)

para@peaksData <- para@peaksData %>% filter( ID %in% mz)

x<-dcast(para@peaksData,class+sample~ID,value.var="valueNorm")
write.table(x,"Features-norm.csv",sep=",",row.names=F)

res<-featureSelection(para,group=c("disease","healthy"),valueID="valueNorm",plotCICurve=FALSE)
para@peaksData <- para@peaksData %>% filter(ID %in% res$optVariables)


#mz<-read.table("LysoPC.txt",header=F)[,1] # mz ID for ROC
#mz<-read.table("PA.txt",header=F)[,1]
#mz<-read.table("PC.txt",header=F)[,1]
mz<-read.table("PI.txt",header=F)[,1]
samples<-read.table("sample.txt",header=F)[,1] # choose the samples exist both in positve and negative mode after outliers exclusion from PCA

posPara<-readRDS("pos-result.rds")
negPara<-readRDS("neg-result.rds")

para<-posPara
para@peaksData<-rbind(para@peaksData,negPara@peaksData)
para@peaksData$sample<-substr(para@peaksData$sample,1,10)
para@peaksData<-para@peaksData %>% filter(sample %in% samples)
para@peaksData<-para@peaksData %>% filter(ID %in% mz)

plotROC(para,group=c("disease","healthy"),fID=mz,valueID="valueNorm",method="rf",ratio=2/3,k=100,plotCICurve=F)
