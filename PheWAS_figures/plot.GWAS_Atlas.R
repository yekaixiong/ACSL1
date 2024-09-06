args    <- commandArgs(trailingOnly=TRUE)
if(is.na(args[1])){
        stop("Usage:Rscript *.R <go>\n")
}
library(Polychrome)
Glasbey = glasbey.colors(32)

data <- read.table("GWAS_Atlas_plot.processed.txt", header=TRUE, sep="\t")
pdf("GWAS_Atlas_PheWAS.pdf", w=7, h=3)
par( mar=c(0.6,2.6,0.6,1.1), mgp=c(1.5, 0.6, 0))
plot(data$idx, -log10(data$pvalue), col=Glasbey[data$Color+4], pch=16, xaxt="n", ylab="-log10(p value)", ylim=c(0,20), frame.plot=F, xlim=c(0,270))
axis(side=1, labels=FALSE)
abline(h=-log10(1.05e-5), col="magenta", lty=2)
abline(h=-log10(5e-8),col="blue",lty=2)

domain<-as.factor(data$Domain)
domain_names<-levels(domain)

dev.off()

pdf("GWAS_Atlas_PheWAS.legend.pdf", w=7, h=3)
par( mar=c(0.6,2.6,0.6,1.1), mgp=c(1.5, 0.6, 0))
plot(data$idx, -log10(data$pvalue), type="n", col=Glasbey[data$Color+4], pch=16, xaxt="n", yaxt="n", ylab="", ylim=c(0,20), frame.plot=F, xlim=c(0,270))
legend("topleft", legend=domain_names[1:10], col=Glasbey[1:10+4], bty="n", pch=16, cex=1.0)
legend("top", legend=domain_names[11:20], col=Glasbey[11:20+4], bty="n", pch=16, cex=1.0)
legend("topright", legend=domain_names[21:length(domain_names)], col=Glasbey[21:length(domain_names)+4], bty="n", pch=16, cex=1.0)
dev.off()