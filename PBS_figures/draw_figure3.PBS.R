args    <- commandArgs(trailingOnly=TRUE)
if(is.na(args[1])){
  stop("Usage:Rscript *.R <go>\n")
}
mycolors<-palette.colors(palette = "Okabe-Ito")

EURi <- read.table("PBS.AFR_EUR_EAS.ACSL1.200Kb.txt", header=TRUE)

Df  <- paste("ACSL1.PBS", ".", "4_pops", ".pdf", sep="", collapse="");
pdf(file=Df, w=7, h=3)
par( mar=c(1.6,2.6,0.6,1.1), mgp=c(1.5, 0.6, 0), xpd=TRUE)
layout(m=matrix(1:4, 2, 2))

## Fig 1 AFR
EURcutoff <- 0.301371780783933
top1 <- 0.578936101660657

idx <- EURi[,4] < 0
EURi[idx,4] <- 0

ymax = max(EURi[,4])
plot(EURi[,2]/10^6, EURi[,4], xlab="", ylab="PBS(AFR)", frame.plot=F, col=1, ylim=c(0, 1), cex.lab=1.1, cex.axis=1.1, lwd=0.4, pch=20, cex=0.4, xaxt = 'n')
axis(1, labels = FALSE)

points(EURi[,2][EURi[,4] > EURcutoff]/10^6, EURi[,4][EURi[,4] > EURcutoff], pch=20, col="magenta", cex=0.8)
segments(x0=185.65, y0=EURcutoff, x1 = 185.85, y1 = EURcutoff, lty=2, col="magenta", lwd=1)
#abline(h=EURcutoff, lty=2, col="magenta", lwd=1)

points(EURi[,2][EURi[,4] > top1]/10^6, EURi[,4][EURi[,4] > top1], pch=20, col="blue", cex=0.8)
segments(x0=185.65, y0=top1, x1 = 185.85, y1 = top1, lty=2, col="blue", lwd=1)
#abline(h=top1, lty=2, col="blue", lwd=1)

text(x=185745610/10^6+0.019, y=(0.77), labels="rs28701695", cex=0.6, col="blue");
text(x=185782086/10^6+0.018, y=(1.03), labels="rs6829140", cex=0.6, col="blue");
text(x=185805506/10^6+0.019, y=(0.765), labels="rs10012462", cex=0.6, col="blue");

#arrows(x0=185676749/10^6, y0=(-0.15), x1=185747972/10^6, y1=(-0.15), lwd=2, code=1, length=0.05)
#arrows(x0=185676749/10^6, y0=(-0.2), x1=185747972/10^6, y1=(-0.2), lwd=2, code=1, length=0.05, col=2)
#arrows(x0=185676749/10^6, y0=(-0.25), x1=185747972/10^6, y1=(-0.25), lwd=2, code=1, length=0.05, col=3)
#arrows(x0=185676749/10^6, y0=(-0.3), x1=185747972/10^6, y1=(-0.3), lwd=2, code=1, length=0.05, col=4)

## Gene model

ACSL1 <- read.table("ACSL1.longest_transcript.gtf.info")
for (i in 1:dim(ACSL1)[1]){
  if(ACSL1[i,1] == "CDS"){
    rect(xleft=c(ACSL1[i,2]/10^6, ACSL1[i,2]/10^6), ybottom=c(-0.24, -0.24), xright=c(ACSL1[i,3]/10^6, ACSL1[i,3]/10^6), ytop=c(-0.16, -0.16), col="black", border="black")
  }else{
    rect(xleft=c(ACSL1[i,2]/10^6, ACSL1[i,2]/10^6), ybottom=c(-0.22, -0.22), xright=c(ACSL1[i,3]/10^6, ACSL1[i,3]/10^6), ytop=c(-0.18, -0.18), col="black", border="black")
    
  }
}
rect(xleft=c(min(ACSL1[,2])/10^6, min(ACSL1[,2])/10^6), ybottom=c(-0.201, -0.201), xright=c(max(ACSL1[,3])/10^6, max(ACSL1[,3])/10^6), ytop=c(-0.199, -0.199), col="black", border="black")
arrows(x0=185747972/10^6-0.02, y0=(-0.14), x1=185747972/10^6, y1=(-0.14), lwd=1, code=1, length=0.05)
text(x=185747972/10^6+0.02, y=(-0.2), labels="ACSL1", cex=1);


## Fig 2 EUR

EURcutoff <- 0.155156539094268
top1 <- 0.331251881967572
ymax = max(EURi[,5])

idx <- EURi[,5] < 0
EURi[idx,5] <- 0

plot(EURi[,2]/10^6, EURi[,5], xlab="", ylab="PBS(EUR)", frame.plot=F, col=1, ylim=c(0, 0.5), cex.lab=1.1, cex.axis=1.1, lwd=0.4, pch=20, cex=0.4)

points(EURi[,2][EURi[,5] > EURcutoff]/10^6, EURi[,5][EURi[,5] > EURcutoff], pch=20, col="magenta", cex=0.8)
#abline(h=EURcutoff, lty=2, col="magenta", lwd=2)
segments(x0=185.65, y0=EURcutoff, x1 = 185.85, y1 = EURcutoff, lty=2, col="magenta", lwd=1)

points(EURi[,2][EURi[,5] > top1]/10^6, EURi[,5][EURi[,5] > top1], pch=20, col="blue", cex=0.8)
#abline(h=top1, lty=2, col="blue", lwd=2)
segments(x0=185.65, y0=top1, x1 = 185.85, y1 = top1, lty=2, col="blue", lwd=1)

text(x=185653772/10^6+0.02, y=(0.55), labels="rs372556974", cex=0.6, col="blue");
text(x=185728811/10^6+0.02, y=(0.40), labels="rs10471180", cex=0.6, col="blue");

## Fig 3 EAS

EURcutoff <- 0.211622648961918
top1 <- 0.440458092685112
ymax = max(EURi[,6])
idx <- EURi[,6] < 0
EURi[idx,6] <- 0

plot(EURi[,2]/10^6, EURi[,6], xlab="", ylab="PBS(EAS)", frame.plot=F, col=1, ylim=c(0, 1), cex.lab=1.1, cex.axis=1.1, lwd=0.4, pch=20, cex=0.4, xaxt="n")
axis(1, labels = FALSE)
points(EURi[,2][EURi[,6] > EURcutoff]/10^6, EURi[,6][EURi[,6] > EURcutoff], pch=20, col="magenta", cex=0.8)
#abline(h=EURcutoff, lty=2, col="magenta", lwd=2)
segments(x0=185.65, y0=EURcutoff, x1 = 185.85, y1 = EURcutoff, lty=2, col="magenta", lwd=1)

points(EURi[,2][EURi[,6] > top1]/10^6, EURi[,6][EURi[,6] > top1], pch=20, col="blue", cex=0.8)
#abline(h=top1, lty=2, col="blue", lwd=2)
segments(x0=185.65, y0=top1, x1 = 185.85, y1 = top1, lty=2, col="blue", lwd=1)

for (i in 1:dim(ACSL1)[1]){
  if(ACSL1[i,1] == "CDS"){
    rect(xleft=c(ACSL1[i,2]/10^6, ACSL1[i,2]/10^6), ybottom=c(-0.24, -0.24), xright=c(ACSL1[i,3]/10^6, ACSL1[i,3]/10^6), ytop=c(-0.16, -0.16), col="black", border="black")
  }else{
    rect(xleft=c(ACSL1[i,2]/10^6, ACSL1[i,2]/10^6), ybottom=c(-0.22, -0.22), xright=c(ACSL1[i,3]/10^6, ACSL1[i,3]/10^6), ytop=c(-0.18, -0.18), col="black", border="black")
    
  }
}
rect(xleft=c(min(ACSL1[,2])/10^6, min(ACSL1[,2])/10^6), ybottom=c(-0.201, -0.201), xright=c(max(ACSL1[,3])/10^6, max(ACSL1[,3])/10^6), ytop=c(-0.199, -0.199), col="black", border="black")
arrows(x0=185747972/10^6-0.02, y0=(-0.14), x1=185747972/10^6, y1=(-0.14), lwd=1, code=1, length=0.05)
text(x=185747972/10^6+0.02, y=(-0.2), labels="ACSL1", cex=1);

text(x=185654320/10^6+0.015, y=(0.87), labels="rs902176", cex=0.6, col="blue");
text(x=185704806/10^6+0.015, y=(0.62), labels="rs1532126", cex=0.6, col="blue");
text(x=185814965/10^6+0.018, y=(0.6), labels="rs7683543", cex=0.6, col="blue");



## Fig 4 SAS
EURi <- read.table("PBS.AFR_EUR_SAS.ACSL1.200Kb.txt", header=TRUE)

EURcutoff <- 0.0709838773238651
top1 <- 0.15640437114313
ymax = max(EURi[,6])
idx <- EURi[,6] < 0
EURi[idx,6] <- 0
plot(EURi[,2]/10^6, EURi[,6], xlab="", ylab="PBS(SAS)", frame.plot=F, col=1, ylim=c(0, 0.3), cex.lab=1.1, cex.axis=1.1, lwd=0.4, pch=20, cex=0.4, yaxt="n")
axis(side=2, at=c(0,0.1,0.2,0.3), labels=c("0.0","0.1","0.2","0.3"))

points(EURi[,2][EURi[,6] > EURcutoff]/10^6, EURi[,6][EURi[,6] > EURcutoff], pch=20, col="magenta", cex=0.8)
#abline(h=EURcutoff, lty=2, col="magenta", lwd=2)
segments(x0=185.65, y0=EURcutoff, x1 = 185.85, y1 = EURcutoff, lty=2, col="magenta", lwd=1)

points(EURi[,2][EURi[,6] > top1]/10^6, EURi[,6][EURi[,6] > top1], pch=20, col="blue", cex=0.8)
#abline(h=top1, lty=2, col="blue", lwd=2)
segments(x0=185.65, y0=top1, x1 = 185.85, y1 = top1, lty=2, col="blue", lwd=1)
text(x=185747362/10^6, y=(0.2), labels="rs56302210", cex=0.6, col="blue");
text(x=185800674/10^6, y=(0.23), labels="rs4555688", cex=0.6, col="blue");
text(x=185839775/10^6, y=(0.23), labels="rs9799462", cex=0.6, col="blue");



dev.off()
