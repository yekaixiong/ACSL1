This folder contains scripts and example files for the calculation of PBS. Note that PBS was calculated for three populations. The input files are the three pairs of Fst.

The Fst for each pair of two populations should be put in a folder. There are three folders for three population-pairs.

An example command line is as follows:
$ perl PBS.calculator.0AFR.1EUR.2SAS.pl 1

1 is the chromosome number. This command calculates PBS for chromosome 1. The example output is "chr1.0AFR.1EUR.2SAS.PBS", which has the following format:
CHR     POS     ID      PBS(AFR)     PBS(EUR)     PBS(SAS)


