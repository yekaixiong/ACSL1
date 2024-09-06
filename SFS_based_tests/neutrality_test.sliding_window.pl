#!/usr/bin/perl
use strict;
use warnings;

## This program is to calculate Site-Frequency-Spectrum-based statistics: pi, Tajima's D and Fay and Wu's H. This script is designed for these two parameters and could not be used for other window sizes or moving steps.
## Date : 2009.
## Programmer : yekaixiong

## ^ is not a symbol in perl, rather I should use **
die "You need to file \"hs37d5.fa.gz.fai\" in the working directory\nUsage:<input of sample size by chromosomes><input of chromosome number><input of summarized genetic variation><output>" unless @ARGV == 4;

my $sample_N = $ARGV[0];
my $chr      = $ARGV[1];
my $bin      = 1000;
my $win_bin  = 5000 / $bin;


my $chr_size = 0;
open IB, "hs37d5.fa.gz.fai" || die "IB:$!\n";
while(<IB>){
	chomp;
	my @tmp = split; 
	if($tmp[0] eq $chr){
		$chr_size = $tmp[1];
	}
}
close IB;

## calculating a1, a2, e1, e2

my $a1 = 0;
my $a2 = 0;
my $e1 = 0;
my $e2 = 0;

for (my $i = 1; $i <= ($sample_N - 1); $i++){
	$a1 += 1/$i;
	$a2 += 1/($i)**2;
}
my $b1 = ($sample_N + 1) / (3*($sample_N-1));
my $c1 = $b1 - (1/$a1);
my $b2 = (2*($sample_N**2 + $sample_N + 3)) / (9*$sample_N*($sample_N-1));
my $c2 = $b2 - (($sample_N+2)/($sample_N*$a1)) + ($a2/$a1**2);

$e1 = $c1 / $a1;
$e2 = $c2 / ($a1**2 + $a2);


my @S_all; 
my @Pi_all;
my @S_aa;
my @Pi_aa;
my @h_aa;
open IA, "$ARGV[2]"  || die "Can't open IA: $!\n";

my $current_variant = 1;
my @current_data = (0,0,0,0,0);
my $idx = -1;
for (my $i = 1; $i <= ( $chr_size - $bin ); $i += $bin){
	$idx++; ## current index in the array
	my $upper_bound = $i + $bin;
	if( $current_variant >= $i && $current_variant < $upper_bound ){  # the current variants is in the bin
		## record the data
		$S_all[$idx] += $current_data[0];
		$Pi_all[$idx]+= $current_data[1];
		$S_aa[$idx]  += $current_data[2];
		$Pi_aa[$idx] += $current_data[3];
		$h_aa[$idx]  += $current_data[4];
		## read the next variant
		my $next_entry;
		while($next_entry = <IA>){
			chomp($next_entry);
			my @tmp = split /\s+/, $next_entry;

			## Since there is missing data (only two alleles are retained), for some loci, the sum is not exactly 2*number of individuals. We have to normalize the total count to be 2*number of individuals, that is, the number of chromosomes.
			$tmp[6] = int ($tmp[6] / ($tmp[6]+$tmp[7]) * $sample_N +0.5); 
			$tmp[7] = $sample_N - $tmp[6];
			next if ($tmp[6] == 0 || $tmp[7] == 0); ## this is not a genetic variant
			## calculation for the current genetic variant
			$current_variant = $tmp[1]; ## genomic position/coordinate
			$current_data[0] = 1;
			$current_data[1] = 2*( $tmp[6] * $tmp[7]) / ($sample_N * ( $sample_N - 1 ));

			my $aa = uc($tmp[5]);
			if( ($aa =~ /\./) || ($aa =~ /\-/) || ($aa =~ /N/) || ($aa ne $tmp[3] && $aa ne $tmp[4]) ){  ## doesn't have ancestral allele
				$current_data[2] = 0;
				$current_data[3] = 0;
				$current_data[4] = 0;
			}else{ ## there is ancestral allele
				if($aa eq $tmp[3]){ ## derived allele is $tmp[4]
					$current_data[2] = 1;
					$current_data[3] = 2*( $tmp[6] * $tmp[7]) / ($sample_N * ( $sample_N - 1 ));
					$current_data[4] = 2*( $tmp[7]**2) / ($sample_N * ( $sample_N - 1 ));
				}elsif($aa eq $tmp[4]){
					$current_data[2] = 1;
					$current_data[3] = 2*( $tmp[6] * $tmp[7]) / ($sample_N * ( $sample_N - 1 ));
					$current_data[4] = 2*( $tmp[6]**2) / ($sample_N * ( $sample_N - 1 ));
				}else{
					die "ancestral allele has problem:\n$next_entry\n";
				}
			}
			## 
			if( $current_variant  >= $i && $current_variant < $upper_bound ){ ## in the bin, continue to read the next entry
		                ## record the data
                		$S_all[$idx] += $current_data[0];
		                $Pi_all[$idx]+= $current_data[1];
                		$S_aa[$idx]  += $current_data[2];
		                $Pi_aa[$idx] += $current_data[3];
                		$h_aa[$idx]  += $current_data[4];
				
			}else{ ##  Outside of bin, continue to read the next interval
				last;
			}
		}
		unless(defined $next_entry){
			$current_variant = -1;  ## Not more variants to read
		}

	}elsif( $current_variant >= $upper_bound){  ## the current variant is further apart
		## all 0
		$S_all[$idx] = 0;
		$Pi_all[$idx]= 0;
		$S_aa[$idx]  = 0;
		$Pi_aa[$idx] = 0;
		$h_aa[$idx]  = 0;
	}else{ ## Not more SNPs to read
		die "$current_variant\n" unless ($current_variant < 0);
		## all are 0
                $S_all[$idx] = 0;
                $Pi_all[$idx]= 0;
                $S_aa[$idx]  = 0;
                $Pi_aa[$idx] = 0;
                $h_aa[$idx]  = 0;				
	}
}
close IA;

open OA, ">$ARGV[3]" || die "OA:$!\n";
my $index = 0;
my $length= scalar @S_all;  ## the number of bins
## Only for 5000 Window Size and 1000 Bin size;
for (my $i = 0; $i < ($length-$win_bin); $i++){
	my $pos = $i * $bin + 1;
	my $win_S_all = $S_all[$i] + $S_all[$i+1] + $S_all[$i+2] + $S_all[$i+3] + $S_all[$i+4];
	my $win_S_aa  = $S_aa[$i] + $S_aa[$i+1] + $S_aa[$i+2] + $S_aa[$i+3] + $S_aa[$i+4];
	if($win_S_all != 0){
		my $theta_W = sprintf "%.6f", $win_S_all / $a1;
		my $theta_Pi= sprintf "%.6f", $Pi_all[$i] + $Pi_all[$i+1] + $Pi_all[$i+2] + $Pi_all[$i+3] + $Pi_all[$i+4];
		my $TajimaD = sprintf "%.6f", ($theta_Pi - $theta_W) / ( $e1 * $win_S_all + $e2 * $win_S_all * ($win_S_all - 1))**0.5;
		my $theta_H_aa;
		my $theta_Pi_aa;
		my $Fay_Wu_H;
		if($win_S_aa == 0){
			$theta_H_aa = "-";
			$theta_Pi_aa= "-";
			$Fay_Wu_H   = "-";
		}else{
			$theta_H_aa = sprintf "%.6f", $h_aa[$i] + $h_aa[$i+1] + $h_aa[$i+2] + $h_aa[$i+3] + $h_aa[$i+4];
			$theta_Pi_aa= sprintf "%.6f", $Pi_aa[$i] + $Pi_aa[$i+1] + $Pi_aa[$i+2] + $Pi_aa[$i+3] + $Pi_aa[$i+4];
			$Fay_Wu_H   = sprintf "%.6f", $theta_Pi_aa - $theta_H_aa;
		}
		print OA "$pos\t$theta_W\t$theta_Pi\t$TajimaD\t$theta_Pi_aa\t$theta_H_aa\t$Fay_Wu_H\n";
	}else{
		print OA "$pos\t-\t-\t-\t-\t-\t-\n";
	}

	$index++;
}
close OA;
