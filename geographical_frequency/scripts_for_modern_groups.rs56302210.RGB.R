library(maps)
library(mapdata)
library(mapplots)
library(plotrix)
data <- read.table("Frequencies_in_modern_groups.rs56302210.txt", header=T)

pdf("Frequencies_in_modern_groups.rs56302210.pdf",h=4.5,w=9)
par(mar=c(0.1,0.1,0.1,0.1))
map("world", interior=FALSE)
cbPalette <- c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")
legend(x=-165, y=-35, legend=c("C","T"), col=c("orange","blue"), bty="n", pch=15, cex=1)
legend(x=-165, y=20, legend=c("African", "American", "East Asian", "European", "South Asian"), pch=1, col=c("black", cbPalette[8], cbPalette[4], "cadetblue1", "purple"), bty="n", cex=1, lty=0, lwd=2, x.intersp=0)

i=1; ## CHB
add.pie(x=data[i,2], y=data[i,3], z=c(1), col=c(cbPalette[4]), labels="", radius=5.2, border=cbPalette[4])
add.pie(x=data[i,2], y=data[i,3], z=c(data[i,5]), col=c("orange"), labels="", radius=4.4, border="orange")

i=2; ## JPT
add.pie(x=data[i,2], y=data[i,3], z=c(1), col=c(cbPalette[4]), labels="", radius=5.2, border=cbPalette[4])
add.pie(x=data[i,2], y=data[i,3], z=c(data[i,5]), col=c("orange"), labels="", radius=4.4, border="orange")

i=3; ## CHS
add.pie(x=data[i,2], y=data[i,3], z=c(1), col=c(cbPalette[4]), labels="", radius=5.2, border=cbPalette[4])
add.pie(x=data[i,2], y=data[i,3], z=c(data[i,5]), col=c("orange"), labels="", radius=4.4, border="orange")

i=4; ## CDX
add.pie(x=data[i,2], y=data[i,3], z=c(1), col=c(cbPalette[4]), labels="", radius=5.2, border=cbPalette[4])
add.pie(x=data[i,2], y=data[i,3], z=c(data[i,5]), col=c("orange"), labels="", radius=4.4, border="orange")

i=5; ## KHV
add.pie(x=data[i,2], y=data[i,3], z=c(1), col=c(cbPalette[4]), labels="", radius=5.2, border=cbPalette[4])
add.pie(x=data[i,2], y=data[i,3], z=c(data[i,5]), col=c("orange"), labels="", radius=4.4, border="orange")

i=6; ## CEU
add.pie(x=data[i,2]-2, y=data[i,3]+3, z=c(1), col=c("cadetblue1"), labels="", radius=5.2, border="cadetblue1")
add.pie(x=data[i,2]-2, y=data[i,3]+3, z=c(data[i,4], data[i,5]), col=c("blue","orange"), labels="", radius=5, border="cadetblue1")
i=7; ## TSI
add.pie(x=data[i,2]+2, y=data[i,3]-1, z=c(1), col=c("cadetblue1"), labels="", radius=5.2, border="cadetblue1")
add.pie(x=data[i,2]+2, y=data[i,3]-1, z=c(data[i,4], data[i,5]), col=c("blue","orange"), labels="", radius=5, border="cadetblue1")
i=8; ## FIN
add.pie(x=data[i,2], y=data[i,3], z=c(1), col=c("cadetblue1"), labels="", radius=5.2, border="cadetblue1")
add.pie(x=data[i,2], y=data[i,3], z=c(data[i,4], data[i,5]), col=c("blue","orange"), labels="", radius=5, border="cadetblue1")
i=9; ## GBR
add.pie(x=data[i,2]-3, y=data[i,3]+4, z=c(1), col=c("cadetblue1"), labels="", radius=5.2, border="cadetblue1")
add.pie(x=data[i,2]-3, y=data[i,3]+4, z=c(data[i,4], data[i,5]), col=c("blue","orange"), labels="", radius=5, border="cadetblue1")
i=10; ## IBS
add.pie(x=data[i,2]-4, y=data[i,3], z=c(1), col=c("cadetblue1"), labels="", radius=5.2, border="cadetblue1")
add.pie(x=data[i,2]-4, y=data[i,3], z=c(data[i,4], data[i,5]), col=c("blue","orange"), labels="", radius=5, border="cadetblue1")

i=11; ## YRI
add.pie(x=data[i,2]-2.5, y=data[i,3]+3, z=c(1), col=c("black"), labels="", radius=5.2, border="black")
add.pie(x=data[i,2]-2.5, y=data[i,3]+3, z=c(data[i,4], data[i,5]), col=c("blue","orange"), labels="", radius=5, border="black")
i=12; ## LWK
add.pie(x=data[i,2], y=data[i,3], z=c(1), col=c("black"), labels="", radius=5.2, border="black")
add.pie(x=data[i,2], y=data[i,3], z=c(data[i,4], data[i,5]), col=c("blue","orange"), labels="", radius=5, border="black")


#### Attention needed ######
i=13; ## GWD
add.pie(x=data[i,2]-1, y=data[i,3]+2, z=c(1), col=c("black"), labels="", radius=5.2, border="black")
add.pie(x=data[i,2]-1, y=data[i,3]+2, z=c(data[i,4], data[i,5]), col=c("blue","orange"), labels="", radius=5, border="black")

#### Attention needed ######
i=14; ## MSL
add.pie(x=data[i,2]+1, y=data[i,3]-1, z=c(1), col=c("black"), labels="", radius=5.2, border="black")
add.pie(x=data[i,2]+1, y=data[i,3]-1, z=c(data[i,4], data[i,5]), col=c("blue", "orange"), labels="", radius=5, border="black")

#### Attention needed ######
i=15; ## ESN
add.pie(x=data[i,2]+3.5, y=data[i,3]-2.5, z=c(1), col=c("black"), labels="", radius=5.2, border="black")
add.pie(x=data[i,2]+3.5, y=data[i,3]-2.5, z=c(data[i,4], data[i,5]), col=c("blue", "orange"), labels="", radius=5, border="black")


i=16; ## ASW
add.pie(x=data[i,2]+1, y=data[i,3]+1, z=c(1), col=c("black"), labels="", radius=5.2, border="black")
add.pie(x=data[i,2]+1, y=data[i,3]+1, z=c(data[i,4], data[i,5]), col=c("blue","orange"), labels="", radius=5, border="black")
i=17; ## ACB
add.pie(x=data[i,2]+1, y=data[i,3]-1, z=c(1), col=c("black"), labels="", radius=5.2, border="black")
add.pie(x=data[i,2]+1, y=data[i,3]-1, z=c(data[i,4], data[i,5]), col=c("blue","orange"), labels="", radius=5, border="black")

i=18; ## MXL
add.pie(x=data[i,2], y=data[i,3]-2, z=c(1), col=c(cbPalette[8]), labels="", radius=5.2, border=cbPalette[8])
add.pie(x=data[i,2], y=data[i,3]-2, z=c(data[i,4], data[i,5]), col=c("blue","orange"), labels="", radius=5, border=cbPalette[8])

i=19; ## PUR
add.pie(x=data[i,2]-1, y=data[i,3]+1, z=c(1), col=c(cbPalette[8]), labels="", radius=5.2, border=cbPalette[8])
add.pie(x=data[i,2]-1, y=data[i,3]+1, z=c(data[i,4], data[i,5]), col=c("blue","orange"), labels="", radius=5, border=cbPalette[8])

i=20; ## CLM
add.pie(x=data[i,2], y=data[i,3], z=c(1), col=c(cbPalette[8]), labels="", radius=5.2, border=cbPalette[8])
add.pie(x=data[i,2], y=data[i,3], z=c(data[i,4], data[i,5]), col=c("blue","orange"), labels="", radius=5, border=cbPalette[8])
i=21; ## PEL
add.pie(x=data[i,2], y=data[i,3], z=c(1), col=c(cbPalette[8]), labels="", radius=5.2, border=cbPalette[8])
add.pie(x=data[i,2], y=data[i,3], z=c(data[i,4], data[i,5]), col=c("blue","orange"), labels="", radius=5, border=cbPalette[8])

i=22; ## GIH
add.pie(x=data[i,2]-2, y=data[i,3]+2, z=c(1), col=c("purple"), labels="", radius=5.2, border="purple")
add.pie(x=data[i,2]-2, y=data[i,3]+2, z=c(data[i,4], data[i,5]), col=c("blue","orange"), labels="", radius=5, border="purple")
i=23; ## PJL
add.pie(x=data[i,2]+2, y=data[i,3]+2, z=c(1), col=c("purple"), labels="", radius=5.2, border="purple")
add.pie(x=data[i,2]+2, y=data[i,3]+2, z=c(data[i,4], data[i,5]), col=c("blue","orange"), labels="", radius=5, border="purple")
i=24; ## BEB
add.pie(x=data[i,2], y=data[i,3], z=c(1), col=c("purple"), labels="", radius=5.2, border="purple")
add.pie(x=data[i,2], y=data[i,3], z=c(data[i,4], data[i,5]), col=c("blue","orange"), labels="", radius=5, border="purple")
i=25; ## STU
add.pie(x=data[i,2], y=data[i,3]-1, z=c(1), col=c("purple"), labels="", radius=5.2, border="purple")
add.pie(x=data[i,2], y=data[i,3]-1, z=c(data[i,4], data[i,5]), col=c("blue","orange"), labels="", radius=5, border="purple")
i=26; ## ITU
add.pie(x=data[i,2]+2, y=data[i,3]+4, z=c(1), col=c("purple"), labels="", radius=5.2, border="purple")
add.pie(x=data[i,2]+2, y=data[i,3]+4, z=c(data[i,4], data[i,5]), col=c("blue","orange"), labels="", radius=5, border="purple")

dev.off()

