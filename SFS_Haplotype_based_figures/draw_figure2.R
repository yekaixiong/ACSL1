args    <- commandArgs(trailingOnly=TRUE)
if(is.na(args[1])){
        stop("Usage:Rscript *.R <go>\n")
}

mycolors<-palette.colors(palette = "Okabe-Ito")


AFR <- read.table("neutrality.AFR.ACSL1.200K.txt")
EUR <- read.table("neutrality.EUR.ACSL1.200K.txt")
EAS <- read.table("neutrality.EAS.ACSL1.200K.txt")
SAS <- read.table("neutrality.SAS.ACSL1.200K.txt")

SASD5 = -2.0019
SASH5 = -10.1122

D_1 = -2.3201 ## EAS 
H_1 = -19.25 ## EUR

D_5 = -2.0575 ## EAS
H_5 = -10.793 ## EUR

pdf(file="Fig2.pdf", w=7, h=4.5)
par( mar=c(1.6,2.6,0.6,1.1), mgp=c(1.5, 0.6, 0))
layout(m=matrix(1:6, 3, 2))

### First plot for pi

pimax <- max(na.omit(c(AFR[,2]*1000,EUR[,2]*1000, EAS[,2]*1000, SAS[,2]*1000)))*1.2

plot(AFR[,1]/10^6, AFR[,2]*1000, xlab="", ylab=expression(paste(pi,"/Kb",sep="")), frame.plot=F, type="l", ylim=c(0,pimax), xlim=c(185.65, 185.85), col=mycolors[1], lwd=1.5, cex.lab=1.3, cex.axis=1.3)

lines(EUR[,1]/10^6, EUR[,2]*1000, col=mycolors[2], lwd=2)
lines(EAS[,1]/10^6, EAS[,2]*1000, col=mycolors[3], lwd=2)
lines(SAS[,1]/10^6, SAS[,2]*1000, col=mycolors[4], lwd=2)
legend("topleft", legend=c("AFR","EUR","EAS","SAS"), lty=1, col=mycolors[1:4], bty="n", lwd=2,horiz=T, cex=1.1)


### second plot for Tajima's D

Dmax <- max(na.omit(c(AFR[,3],EUR[,3], EAS[,3], SAS[,3])))*1.2

plot(AFR[,1]/10^6, AFR[,3], xlab="", ylab="Tajima's D", frame.plot=F, type="l",col=mycolors[1], ylim=c(-2.5, 2.8), xlim=c(185.65, 185.85), lwd=2, cex.lab=1.3, cex.axis=1.3)
lines(EUR[,1]/10^6, EUR[,3], col=mycolors[2], lwd=2)
lines(EAS[,1]/10^6, EAS[,3], col=mycolors[3], lwd=2)
lines(SAS[,1]/10^6, SAS[,3], col=mycolors[4], lwd=2)

abline(h=D_5, col="magenta", lty=2, lwd=1)
abline(h=D_1, col="blue", lty=2, lwd=1)

### third plot for Fay and Wu's H

plot(AFR[,1]/10^6, AFR[,4], xlab="", ylab="Fay and Wu's H", frame.plot=F, type="l",col=mycolors[1], ylim=c(-38, 10), lwd=2, cex.lab=1.3, cex.axis=1.3)
lines(EUR[,1]/10^6, EUR[,4], col=mycolors[2], lwd=2)
lines(EAS[,1]/10^6, EAS[,4], col=mycolors[3], lwd=2)
lines(SAS[,1]/10^6, SAS[,4], col=mycolors[4], lwd=2)

abline(h=H_5, col="magenta", lty=2,lwd=1)
abline(h=H_1, col="blue", lty=2,lwd=1)

## Gene model

ACSL1 <- read.table("ACSL1.longest_transcript.gtf.info")
for (i in 1:dim(ACSL1)[1]){
  if(ACSL1[i,1] == "CDS"){
    rect(xleft=c(ACSL1[i,2]/10^6, ACSL1[i,2]/10^6), ybottom=c(-37, -37), xright=c(ACSL1[i,3]/10^6, ACSL1[i,3]/10^6), ytop=c(-33, -33), col="black", border="black")
  }else{
    rect(xleft=c(ACSL1[i,2]/10^6, ACSL1[i,2]/10^6), ybottom=c(-36, -36), xright=c(ACSL1[i,3]/10^6, ACSL1[i,3]/10^6), ytop=c(-34, -34), col="black", border="black")
    
  }
}
rect(xleft=c(min(ACSL1[,2])/10^6, min(ACSL1[,2])/10^6), ybottom=c(-35.1, -35.1), xright=c(max(ACSL1[,3])/10^6, max(ACSL1[,3])/10^6), ytop=c(-34.9, -34.9), col="black", border="black")
arrows(x0=185747972/10^6-0.02, y0=(-31), x1=185747972/10^6, y1=(-31), lwd=1, code=1, length=0.05)
text(x=185747972/10^6+0.02, y=(-35), labels="ACSL1", cex=1.2);


### fifth plot -- sixth plot

AFRi <- read.table("iHS.AFR.ACSL1.200K.txt")
EURi <- read.table("iHS.EUR.ACSL1.200K.txt")
EASi <- read.table("iHS.EAS.ACSL1.200K.txt")
SASi <- read.table("iHS.SAS.ACSL1.200K.txt")

iHS1 = -2.43403 ## SAS
iHS5 = -1.66607 ## EAS
iHS95= 1.62985  ## AFR
iHS99= 2.38929  ## AFR

AFRn <- read.table("nSL.AFR.ACSL1.200K.txt")
EURn <- read.table("nSL.EUR.ACSL1.200K.txt")
EASn <- read.table("nSL.EAS.ACSL1.200K.txt")
SASn <- read.table("nSL.SAS.ACSL1.200K.txt")

nSL1 <- -2.55229 ## AFR
nSL5 <- -1.75015 ## SAS
nSL95<- 1.50803  ## EAS
nSL99<- 2.00141  ## AFR

## fifth plot iHS
plot(AFRi[,2]/10^6, AFRi[,3], xlab="", ylab="normalized iHS", frame.plot=F, col=mycolors[1], ylim=c(-4, 3.5), cex.lab=1.3, cex.axis=1.3, lwd=0.4, pch=1, cex=0.4)
abline(h=iHS1, lty=2, col="blue")
abline(h=iHS5, lty=2, col="magenta")
abline(h=iHS99, lty=2, col="blue")
abline(h=iHS95, lty=2, col="magenta")

points(EURi[,2]/10^6, EURi[,3], col=mycolors[2], lwd=0.4, cex=0.4, pch=1)
points(EASi[,2]/10^6, EASi[,3], col=mycolors[3], lwd=0.4, cex=0.4, pch=1)
points(SASi[,2]/10^6, SASi[,3], col=mycolors[4], lwd=0.4, cex=0.4, pch=1)

idx <- AFRi[,3] < iHS5 | AFRi[,3] > iHS95
points(AFRi[idx,2]/10^6, AFRi[idx,3],col=mycolors[1], lwd=0.4, cex=0.4, pch=20)
idx <- EURi[,3] < iHS5 | EURi[,3] > iHS95
points(EURi[idx,2]/10^6, EURi[idx,3], col=mycolors[2], lwd=0.4, cex=0.4, pch=20)
idx <- EASi[,3] < iHS5 | EASi[,3] > iHS95
points(EASi[idx,2]/10^6, EASi[idx,3], col=mycolors[3], lwd=0.4, cex=0.4, pch=20)
idx <- SASi[,3] < iHS5 | SASi[,3] > iHS95
points(SASi[idx,2]/10^6, SASi[idx,3], col=mycolors[4], lwd=0.4, cex=0.4, pch=20)

text(x=185733791/10^6-0.015, y=(-2.15), labels="rs112806869", cex=0.6, col=mycolors[1]);
text(x=185749878/10^6, y=(-3.5), labels="rs10002197", cex=0.6, col=mycolors[4]);
arrows(x0=185749878/10^6, y0=(-1.93), x1=185749878/10^6, y1=(-3.2), lwd=0.8, code=2, length=0.02, col=mycolors[4])

text(x=185749878/10^6-0.02, y=(-3), labels="rs10002197", cex=0.6, col=mycolors[2]);
arrows(x0=185749878/10^6, y0=(-1.83), x1=185749878/10^6-0.01, y1=(-2.7), lwd=0.8, code=2, length=0.02, col=mycolors[2])

### sixth plot nSL
ymin = min(c(AFRn[,3], EURn[,3], EASn[,3], SASn[,3]))*1.5
ymax = max(c(AFRn[,3], EURn[,3], EASn[,3], SASn[,3]))*1.2
plot(AFRn[,2]/10^6, AFRn[,3], ylab="normalized nSL", frame.plot=F, col=mycolors[1], ylim=c(-4.5, 3), cex.lab=1.3, cex.axis=1.3, lwd=0.4, pch=1, cex=0.4, xlab="")
abline(h=nSL1, lty=2, col="blue")
abline(h=nSL5, lty=2, col="magenta")
abline(h=nSL99, lty=2, col="blue")
abline(h=nSL95, lty=2, col="magenta")
points(EURn[,2]/10^6, EURn[,3], col=mycolors[2], lwd=0.4, cex=0.4, pch=1)
points(EASn[,2]/10^6, EASn[,3], col=mycolors[3], lwd=0.4, cex=0.4, pch=1)
points(SASn[,2]/10^6, SASn[,3], col=mycolors[4], lwd=0.4, cex=0.4, pch=1)

idx <- AFRn[,3] < nSL5 | AFRn[,3] > nSL95
points(AFRn[idx,2]/10^6, AFRn[idx,3],col=mycolors[1], lwd=0.4, cex=0.4, pch=20)
idx <- EURn[,3] < nSL5 | EURn[,3] > nSL95
points(EURn[idx,2]/10^6, EURn[idx,3], col=mycolors[2], lwd=0.4, cex=0.4, pch=20)
idx <- EASn[,3] < nSL5 | EASn[,3] > nSL95
points(EASn[idx,2]/10^6, EASn[idx,3], col=mycolors[3], lwd=0.4, cex=0.4, pch=20)
idx <- SASn[,3] < nSL5 | SASn[,3] > nSL95
points(SASn[idx,2]/10^6, SASn[idx,3], col=mycolors[4], lwd=0.4, cex=0.4, pch=20)

text(x=185732418/10^6-0.012, y=(-3.1), labels="rs144057088", cex=0.6, col=mycolors[1]);
text(x=185734733/10^6, y=(2.42), labels="rs73014111", cex=0.6, col=mycolors[1]);
text(x=185731940/10^6+0.02, y=(-2.9), labels="rs13126272", cex=0.6, col=mycolors[2]);
arrows(x0=185731940/10^6, y0=(-2.15), x1=185731940/10^6+0.018, y1=(-2.6), lwd=0.8, code=2, length=0.02, col=mycolors[2])
text(x=185686032/10^6, y=(-2.3), labels="rs2292898", cex=0.6, col=mycolors[2]);
text(x=185674501/10^6-0.01, y=(-3), labels="rs11935201", cex=0.6, col=mycolors[3]);
arrows(x0=185674501/10^6, y0=(-1.855), x1=185674501/10^6-0.01, y1=(-2.75), lwd=0.8, code=2, length=0.02, col=mycolors[3])
text(x=185732517/10^6+0.018, y=(-3.3), labels="rs28535270", cex=0.6, col=mycolors[4]);
arrows(x0=185732517/10^6+0.001, y0=(-2.3), x1=185732517/10^6+0.005, y1=(-3.1), lwd=0.8, code=2, length=0.02, col=mycolors[4])
text(x=185713568/10^6, y=(-2.75), labels="rs10022018", cex=0.6, col=mycolors[4]);


for (i in 1:dim(ACSL1)[1]){
  if(ACSL1[i,1] == "CDS"){
    rect(xleft=c(ACSL1[i,2]/10^6, ACSL1[i,2]/10^6), ybottom=c(-4.4, -4.4), xright=c(ACSL1[i,3]/10^6, ACSL1[i,3]/10^6), ytop=c(-4.0, -4.0), col="black", border="black")
  }else{
    rect(xleft=c(ACSL1[i,2]/10^6, ACSL1[i,2]/10^6), ybottom=c(-4.3, -4.3), xright=c(ACSL1[i,3]/10^6, ACSL1[i,3]/10^6), ytop=c(-4.1, -4.1), col="black", border="black")
    
  }
}
rect(xleft=c(min(ACSL1[,2])/10^6, min(ACSL1[,2])/10^6), ybottom=c(-4.19, -4.19), xright=c(max(ACSL1[,3])/10^6, max(ACSL1[,3])/10^6), ytop=c(-4.21, -4.21), col="black", border="black")
arrows(x0=185747972/10^6-0.015, y0=(-3.8), x1=185747972/10^6, y1=(-3.8), lwd=1, code=1, length=0.05)
text(x=185747972/10^6+0.02, y=(-4.2), labels="ACSL1", cex=1.2);




dev.off()
