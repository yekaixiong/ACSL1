args    <- commandArgs(trailingOnly=TRUE)
if(is.na(args[1])){
        stop("Usage:Rscript *.R <go>\n")
}

library(dplyr)

# Create Data
data <- read.table("GWAS_Catalog.groupings.tabulated.txt", sep="\t", header=TRUE)

data <- data %>% 
  mutate(prop = round(value / sum(data$value) *100, digits = 3)) %>%
  mutate(ypos = cumsum(prop)- 0.5*prop ) %>%
  mutate(label0 = paste(round(prop,2), "%", sep = "") )

# Combine the labels with the percentages
labels <- paste(data$group, data$label0, sep = "\n")

mycolors<-palette.colors(palette = "Okabe-Ito")
mycolors2<-hcl.colors(n=10, palette="Dark2")

pdf(file="GWAS.catalog.pie.pdf", w=7, h=7)
# Create the pie chart
#par(lwd = 2)
pie(data$value, labels = labels, main = "", col = mycolors[1:length(data$value)+1], border="white", cex=0.8)
#par(lwd = 1)
# Add a legend to the chart

#legend("topleft", legend = labels, fill = mycolors[1:length(data$value)+1])
dev.off()


pdf(file="GWAS.catalog.pie.no_label.pdf", w=5, h=5)
pie(data$value, labels = NA, main = "", col = mycolors[1:length(data$value)+1], border="white", cex=0.8)
dev.off()
