#!/usr/bin/perl
use strict;
use warnings;

## This program is to summarize variation data from VCF files for a provided list of individuals. This step prepares the input file for the following Site-Frequency-Spectrum-based tests.
## Programmer : Kaixiong Ye; ky279@cornell.edu

die "Usage:<file for ind list><input file of gizpped VCF><output file name>" unless @ARGV == 3;


open IB, "$ARGV[0]" || die "IB:$!\n";
my %POP;
while(<IB>){
	chomp;
	my @tmp = split;
	$POP{$tmp[0]} = 1;
}
close IB;

open IA, "gzip -d -c $ARGV[1] |"  || die "Can't open IA: $!\n";
open OA, ">$ARGV[2]" || die "OA:$!\n";
my %defined_pos;
while (<IA>) {
	chomp;
	if(/^##/){
		next;
	}elsif(/^#CHROM/){
		my @tmp = split; 
		my $idx = 0;
		## Only use specified individuals
		foreach my $ind (@tmp){
			$defined_pos{$idx} = 1 if (defined $POP{$ind});
			$idx++;
		}
	}else{
		my @tmp = split;

		## Extract information about ancestral allele
		my $info= $tmp[7];
		my @inf = split /\;/, $info;
        	my $AA  = ".";  ## NO information about ancestral allele

		if($inf[-1] =~ /AA/){ ## there is information about ancestral allele
			my @alleles = split /\|/, $inf[-1];
			my @anc     = split /\=/, $alleles[0];
			my $ainfo;
			if(defined $anc[1]){
				$AA = uc($anc[1]);
			}
		}
		## Summarize variation information
		 # For multiallelic loci, only the first two alleles with highest frequency are retained.

		my @alt_alleles = split /\,/, $tmp[4];
		my $num_alt     = scalar @alt_alleles;
		
		my $idx = 0;
		my %count;
		for (my $i = 0; $i<=$num_alt; $i++){
			$count{$i} = 0;
		}
		foreach my $ind (@tmp){
			if(defined $defined_pos{$idx}){
				my @inf = split /\:/, $ind;
				my @base= split /\|/, $inf[0];
				$count{$base[0]}++;
				$count{$base[1]}++;
			}
			$idx++;
		}
		my @sorted_allele = sort {$count{$b} <=> $count{$a}} keys %count; ## sort allele index by their occurence ;
		my $idx_allele1   = $sorted_allele[0];
		my $idx_allele2   = $sorted_allele[1];
		if ($idx_allele1 != 0 && $idx_allele2 != 0){ ## Neither of the allele is the reference allele, remove this site;
			next;
		}
		unshift @alt_alleles, $tmp[3]; ## push the reference allele at index 0;
		my $altbase;
		my $altidx;
		if($idx_allele1 == 0){ ## reference allele;
			$altbase = $alt_alleles[$idx_allele2];
			$altidx  = $idx_allele2;
		}else{
			$altbase = $alt_alleles[$idx_allele1];
			$altidx  = $idx_allele1;
		}
		print OA "$tmp[0]\t$tmp[1]\t$tmp[2]\t$tmp[3]\t$altbase\t$AA\t$count{0}\t$count{$altidx}\n";
	}
}
close OA;
close IA;
