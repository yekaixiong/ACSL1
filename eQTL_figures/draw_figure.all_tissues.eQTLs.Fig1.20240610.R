args    <- commandArgs(trailingOnly=TRUE)
if(is.na(args[1])){
        stop("Usage:Rscript *.R <go>\n")
}

#Df  <- paste("ACSL1", ".", "Fig1", ".pdf", sep="", collapse="");
#pdf(file=Df, w=4.75,h=6)

Df  <- paste("ACSL1", ".", "Fig1.20240610", ".png", sep="", collapse="");
png(file=Df, units="in", res=500, w=3.17,h=4)
par( mar=c(0.1,2.6,0.1,1.1), mgp=c(1.5, 0.5, 0))
layout(m=matrix(1:3, 3, 1))

data <- read.table("ACSL1_eQTLs.all_tissues.hg19.txt", header=TRUE, sep="\t")

#### empty plot for legends
plot(data[,2]/10^6, -log10(data[,3]), pch="", xlab="", ylab="", bty="n",xaxt="n", yaxt="n", ylim=c(0,40), main="", col="gray")
allcolors = c("blue", "dodgerblue", "purple","saddlebrown","orange","orchid2","darkgray","turquoise");
legend("topleft", legend=c("Skin - Sun Exposed (Lower leg) (134)", "Skin - Not Sun Exposed (Suprapubic) (1)","Cells-Cultured fibroblasts (26)","Brain-Cerebellar Hemisphere (16)","Brain-Cerebellum (9)","Whole Blood (6)", "Muscle-Skeletal (1)", "Artery-Tibial (1)"), col=allcolors, bty="n", pch=16, text.col =allcolors)

allcolors2=c("red","chartreuse3","yellow4","coral2")
legend("bottomright",legend=c("Testis (93)", "Spleen (3)","Pancreas (2)","Colon-Sigmoid (1)"),col=allcolors2, bty="n", pch=16, text.col =allcolors2)


#### All eQTLs in all tissues

testis_idx = data[,4] == "Testis"
skin1_idx  = data[,4] == "Skin - Sun Exposed (Lower leg)"
skin0_idx  = data[,4] == "Skin - Not Sun Exposed (Suprapubic)"
fibroblast_idx  = data[,4] == "Cells - Cultured fibroblasts"
brain0_idx = data[,4] == "Brain - Cerebellar Hemisphere"
brain1_idx = data[,4] == "Brain - Cerebellum"
blood_idx  = data[,4] == "Whole Blood"
spleen_idx = data[,4] == "Spleen"
pancreas_idx=data[,4] == "Pancreas"
colon_idx  = data[,4] == "Colon - Sigmoid"
artery_idx = data[,4] == "Artery - Tibial"
muscle_idx = data[,4] == "Muscle - Skeletal"

par( mar=c(1.6,2.6,0.1,1.1), mgp=c(1.5, 0.5, 0))
plot(data[,2]/10^6, -log10(data[,3]), pch=20, xlab="Chr4", ylab="-log10(p)", bty="n", yaxt="n", ylim=c(0,40), main="", col="gray")
axis(side=2, at=c(0,10,20,30,40), labels=c("0","10","20","30","40"))
segments(x0=185.65, y0=2, x1=185.65, y1=40, lty=2, col="gray")
segments(x0=185.85, y0=2, x1=185.85, y1=40, lty=2, col="gray")
arrows(x0=185676749/10^6, y0=(1), x1=185747972/10^6, y1=(1), lwd=2, code=1, length=0.05)
text(x=185747972/10^6+0.15, y=(1), labels="ACSL1", cex=1);

points(data[testis_idx,2]/10^6, -log10(data[testis_idx,3]), pch=20, col="red")
points(data[skin1_idx,2]/10^6, -log10(data[skin1_idx,3]), pch=20, col="blue")
points(data[skin0_idx,2]/10^6, -log10(data[skin0_idx,3]), pch=20, col="dodgerblue")
points(data[fibroblast_idx,2]/10^6, -log10(data[fibroblast_idx,3]), pch=20, col="purple")
points(data[brain0_idx,2]/10^6, -log10(data[brain0_idx,3]), pch=20, col="saddlebrown")
points(data[brain1_idx,2]/10^6, -log10(data[brain1_idx,3]), pch=20, col="orange")
points(data[blood_idx,2]/10^6, -log10(data[blood_idx,3]), pch=20, col="orchid2")
points(data[spleen_idx,2]/10^6, -log10(data[spleen_idx,3]), pch=20, col="chartreuse3")
points(data[pancreas_idx,2]/10^6, -log10(data[pancreas_idx,3]), pch=20, col="yellow4")
points(data[colon_idx,2]/10^6, -log10(data[colon_idx,3]), pch=20, col="coral2")
points(data[artery_idx,2]/10^6, -log10(data[artery_idx,3]), pch=20, col="turquoise")
points(data[muscle_idx,2]/10^6, -log10(data[muscle_idx,3]), pch=20, col="darkgray")

#allcolors = c("blue", "dodgerblue", "purple","saddlebrown","orange","orchid2");
#legend("topleft", legend=c("Skin - Sun Exposed (Lower leg) (134)", "Skin - Not Sun Exposed (Suprapubic) (1)","Cells-Cultured fibroblasts (26)","Brain-Cerebellar Hemisphere (16)","Brain-Cerebellum (9)","Whole Blood (6)"), col=allcolors, bty="n", pch=16, text.col =allcolors)

#allcolors2=c("red","chartreuse3","yellow4","coral2","turquoise","darkgray")
#legend("topright",legend=c("Testis (93)", "Spleen (3)","Pancreas (2)","Colon-Sigmoid (1)","Artery-Tibial (1)","Muscle-Skeletal (1)"),col=allcolors2, bty="n", pch=16, text.col =allcolors2)


### selected region

plot(data[,2]/10^6, -log10(data[,3]), pch=20, xlab="Chr4", ylab="-log10(p)", bty="n", yaxt="n", ylim=c(0,40),xlim=c(185.65, 185.85), main="", col="gray")
axis(side=2, at=c(0,10,20,30,40), labels=c("0","10","20","30","40"))

points(data[testis_idx,2]/10^6, -log10(data[testis_idx,3]), pch=20, col="red")
points(data[skin1_idx,2]/10^6, -log10(data[skin1_idx,3]), pch=20, col="blue")
points(data[skin0_idx,2]/10^6, -log10(data[skin0_idx,3]), pch=20, col="dodgerblue")
points(data[fibroblast_idx,2]/10^6, -log10(data[fibroblast_idx,3]), pch=20, col="purple")
points(data[brain0_idx,2]/10^6, -log10(data[brain0_idx,3]), pch=20, col="saddlebrown")
points(data[brain1_idx,2]/10^6, -log10(data[brain1_idx,3]), pch=20, col="orange")
points(data[blood_idx,2]/10^6, -log10(data[blood_idx,3]), pch=20, col="orchid2")
points(data[spleen_idx,2]/10^6, -log10(data[spleen_idx,3]), pch=20, col="chartreuse3")
points(data[pancreas_idx,2]/10^6, -log10(data[pancreas_idx,3]), pch=20, col="yellow4")
points(data[colon_idx,2]/10^6, -log10(data[colon_idx,3]), pch=20, col="coral2")
points(data[artery_idx,2]/10^6, -log10(data[artery_idx,3]), pch=20, col="turquoise")
points(data[muscle_idx,2]/10^6, -log10(data[muscle_idx,3]), pch=20, col="darkgray")



ACSL1 <- read.table("ACSL1.longest_transcript.gtf.info")


for (i in 1:dim(ACSL1)[1]){
        if(ACSL1[i,1] == "CDS"){
                rect(xleft=c(ACSL1[i,2]/10^6, ACSL1[i,2]/10^6), ybottom=c(0.5, 0.5), xright=c(ACSL1[i,3]/10^6, ACSL1[i,3]/10^6), ytop=c(2.5, 2.5), col="black", border="black")
        }else{
                rect(xleft=c(ACSL1[i,2]/10^6, ACSL1[i,2]/10^6), ybottom=c(0.9, 0.9), xright=c(ACSL1[i,3]/10^6, ACSL1[i,3]/10^6), ytop=c(2.1, 2.1), col="black", border="black")
             
        }
}

rect(xleft=c(min(ACSL1[,2])/10^6, min(ACSL1[,2])/10^6), ybottom=c(1.4, 1.4), xright=c(max(ACSL1[,3])/10^6, max(ACSL1[,3])/10^6), ytop=c(1.6, 1.6), col="black", border="black")
arrows(x0=185747972/10^6-0.01, y0=(0), x1=185747972/10^6, y1=(0), lwd=1, code=1, length=0.05)
text(x=185747972/10^6+0.015, y=(1), labels="ACSL1", cex=1);



dev.off()
