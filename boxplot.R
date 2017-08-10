library(metaX)
library(plyr)
library(ggplot2)
library(reshape2)
library(dplyr)

##### positive #####
para<-readRDS("pos-result.rds")

x<-read.table("Features.txt",header=T,sep="\t")
mz<-x[x$mode=="positive",2]

#samples<-c("disease","healthy")

para@peaksData<-para@peaksData %>% filter(ID %in% mz)

para@peaksData$class <- as.character(para@peaksData$class)
peaksData<-para@peaksData
peaksData[is.na(peaksData$class),5]<-"QC"
#peaksData <- dplyr::filter(para@peaksData,class %in% samples)

if(sum(peaksData$valueNorm<=0)>=1){
  stop("cannot handle with <=0 value when log...\n")
}else{
  peaksData$valueNorm<-log2(peaksData$valueNorm)
}

peaks<-merge(peaksData,x,by.x="ID",by.y="ID")

pdf("pos-diff-lipids-boxplot.pdf",width = 2,height = 2)
figres <- ddply(peaks,.(ID),function(dat){
  dat$class <- as.factor(dat$class)
  ggobj <- ggplot(data=dat,aes(x=class,y=valueNorm))+
    geom_boxplot(width = 0.5,aes(fill=class))+theme_bw()+
    theme(legend.position="none")+
    ylab("log2(Intensity)")+xlab(dat$Description[1])
  
  print(ggobj)
  NA
})
dev.off()



##### negative #########
para<-readRDS("neg-result.rds")

x<-read.table("Features.txt",header=T,sep="\t")
mz<-x[x$mode=="negative",2]

#samples<-c("disease","healthy")

para@peaksData<-para@peaksData %>% filter(ID %in% mz)

para@peaksData$class <- as.character(para@peaksData$class)
peaksData<-para@peaksData
peaksData[is.na(peaksData$class),5]<-"QC"
#peaksData <- dplyr::filter(para@peaksData,class %in% samples)

if(sum(peaksData$valueNorm<=0)>=1){
	stop("cannot handle with <=0 value when log...\n")
}else{
	peaksData$valueNorm<-log2(peaksData$valueNorm)
}

peaks<-merge(peaksData,x,by.x="ID",by.y="ID")

pdf("neg-diff-lipids-boxplot.pdf",width = 2,height = 2)
figres <- ddply(peaks,.(ID),function(dat){
dat$class <- as.factor(dat$class)
ggobj <- ggplot(data=dat,aes(x=class,y=valueNorm))+
geom_boxplot(width = 0.5,aes(fill=class))+theme_bw()+
theme(legend.position="none")+
 ylab("log2(Intensity)")+xlab(dat$Description[1])

print(ggobj)
NA
})
dev.off()



