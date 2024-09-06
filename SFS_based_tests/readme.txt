This folder contains scripts and example files for the calculation of Site-Frequency-Spectrum-based statistics: pi, Tajima's D and Fay and Wu's H.

1) Step 1 -- Extract variation data from VCF files for a provided list of individuals. You should download the gzipped vcf files from 1000 Genomes Project. An example command line is as follows:
$ perl extract_and_summarize_variation_data.pl  ind.list.EUR  ALL.chr11.phase3_shapeit2_mvncall_integrated_v5.20130502.genotypes.vcf.gz  extracted_and_summarized_variation_data.chr11.txt

An example output file is "extracted_and_summarized_variation_data.chr11.txt", whose format is:
Chr#  Position  rsID  Ref_Allele  Alt_Allele  Ancestral_Allele Ref_Allele_Count  Alt_Allele_Count


2) Step 2 -- Calculate Site-Frequency-Spectrum-based statistics: pi, Tajima's D and Fay and Wu's H. It applies a sliding window approach with window size of 5000 bp and moving step of 1000 bp. This script is designed for these two parameters and could not be used for other window sizes or moving steps. 

An example command line is as follows:
$ perl neutrality_test.sliding_window.pl  1008  11  extracted_and_summarized_variation_data.chr11.txt neutrality_statistics.chr11.txt

In this command line, 1008 is the sample size (in Chromosomes) of EUR in 1000GP, 11 is the chromosome. An example output file is "neutrality_statistics.chr11.txt", whose format is:
Starting_Position_of_the_window  theta_W  theta_Pi  TajimaD  theta_Pi_aa  theta_H_aa  Fay_Wu_H
"theta_Pi_aa" and "theta_H_aa" refer to theta_Pi and theta_H calculated from variants with ancestral allele information.


