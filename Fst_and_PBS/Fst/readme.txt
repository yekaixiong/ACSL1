This folder contains scripts and example files for the calculation of Fst. Note that Fst was calculated for each pair of two populations.

1) Step 1 -- Extract variation data from VCF files for each of the five continental populations (AFR, AMR, EUR, EAS, and SAS). You should download the gzipped vcf files and the associated individual list from 1000 Genomes Project. An example command line is as follows:
$ perl extract_and_summarize_variation_data.pl  integrated_call_samples_v3.20130502.ALL.panel  ALL.chr1.phase3_shapeit2_mvncall_integrated_v5.20130502.genotypes.vcf.gz chr1.Fst_preparation

An example output file is "chr1.Fst_preparation.example", whose format is:
Chr#  Position  rsID  Ref_Allele  Alt_Allele  (sample size of individuals; heterozygosity rate; ref allele frequency) for AFR, AMR, EUS, EAS, and SAS.

For each pair of two populations, perform the following two steps:

2) Step 2 -- From the Step 1 output, extract variation data only for these two populations.

An example command line is as follows:
$ perl prepare_Fst_input_file.pl  chr1.Fst_preparation.example AFR  EAS

In this command line, the two populations used in this analysis are AFR and EAS. An example output file is "chr1.Fst_preparation.example.AFR_EAS", whose format is:


Chr#  Position  rsID  Ref_Allele  Alt_Allele (sample size of chromosomes; ref allele frequency) for population 1 and then for population 2.

3) Step 3 -- Calculate Fst for each variant using the Hudson's estimator. An example command line is as follows:


$ perl Fst_calculator_for_each_SNP.pl chr1.Fst_preparation.example.AFR_EAS  chr1.example.AFR_EAS.Fst


An example output file is "chr1.example.AFR_EAS.Fst", whose format is:


Chr#  Position  rsID Fst