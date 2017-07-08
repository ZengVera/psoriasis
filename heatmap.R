library(pheatmap)

data<-read.csv("Features-norm.csv",header=T,check.names=F)

names<-read.table("Features.txt",header=T)
class<-data.frame(data$class)
class[,1]<-as.character(class[,1])
colnames(class)<-"class"

rownames(class)<-data$sample

rownames(data)<-data$sample
data<-data[,c(-1,-2)]
data<-t(data)
data<-cbind(rownames(data),data)
colnames(data)[1]<-"mz"
data<-merge(names,data,by.x="ID",by.y="mz",sort=F)
data<-data[,-(1:3)]
rownames(data)<-data[,1]
data[,1]<-NULL
dat<-matrix(as.numeric(as.matrix(data)),nrow=nrow(data))

rownames(dat)<-rownames(data)
colnames(dat)<-colnames(data)
rownames(dat)
dat<-log2(dat)
pdf("heatmap.pdf",w=6,h=3)
pheatmap(dat,annotation=class,scale="row",
         color=colorRampPalette(c("green","black","red"))(255),
         show_colnames=F,show_rownames=T,border_color=NA,cluster_cols = F,cluster_rows=F)
dev.off()



