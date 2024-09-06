#!/usr/bin/perl
use strict;
use warnings;

## Programmer : yekaixiong

## ^ is not a symbol in perl, rather I should use **
die "Usage:<ind list><input of gizpped VCF><output>" unless @ARGV == 3;

open IB, "$ARGV[0]" || die "IB:$!\n";
<IB>;
my %pop;
while(<IB>){
	chomp;
	my @tmp = split;
	$pop{$tmp[0]} = $tmp[2];
}
close IB;

open IA, "gzip -d -c $ARGV[1] |"  || die "Can't open IA: $!\n";
open OA, ">$ARGV[2]" || die "OA:$!\n";
my %CODE = ("0|0" => "00", "0|1" => "01", "1|0" => "01", "1|1" => "11");
my %ASN_pos;
while (<IA>) {
	chomp;
	if(/^##/){
		next;
	}elsif(/^#CHROM/){
		my @tmp = split; 
		my $idx = 0;
		foreach my $ind (@tmp){
			$ASN_pos{$idx} = $pop{$ind} if (defined $pop{$ind});
			$idx++;
		}
	}else{
		my @tmp = split;
		
		my $idx = 0;
		# (sample size, heterozygote, ref_allele)
		my %res;
		$res{"AFR"} = [0,0,0];
		$res{"AMR"} = [0,0,0];
		$res{"EAS"} = [0,0,0];
		$res{"EUR"} = [0,0,0];
		$res{"SAS"} = [0,0,0];
		foreach my $ind (@tmp){
			my $popcode = $ASN_pos{$idx};
			if(defined $ASN_pos{$idx}){
				my @inf = split /\:/, $ind;
				my $genotype = $inf[0];
				if(! defined $CODE{$genotype}){  ## genotype other than 0|0, 0|1, 1|0, and 1|1. 
					## don't count these individuals
				}elsif($CODE{$genotype} eq "00"){
					$res{$popcode}->[0]++;
					$res{$popcode}->[2] += 2;
				}elsif($CODE{$genotype} eq "01"){
					$res{$popcode}->[0]++;
					$res{$popcode}->[2]++;
					$res{$popcode}->[1]++;
				}elsif($CODE{$genotype} eq "11"){
					$res{$popcode}->[0]++;
				}
			}  
			$idx++;
		}
		my %ASN_r;

		foreach my $popcode (keys %res){
			my @array = @{$res{$popcode}};
			if ($array[0] != 0){
				$ASN_r{$popcode}->{"h"} = sprintf "%.6f",  $array[1] / $array[0];
				$ASN_r{$popcode}->{"p"} = sprintf "%.6f",  $array[2] / (2 * $array[0]);
			}else{
				$ASN_r{$popcode}->{"h"} = "NA";
				$ASN_r{$popcode}->{"p"} = "NA";
			}

		}
		print OA "$tmp[0]\t$tmp[1]\t$tmp[2]\t$tmp[3]\t$tmp[4]\t$res{'AFR'}->[0]\t$ASN_r{'AFR'}->{'h'}\t$ASN_r{'AFR'}->{'p'}\t$res{'AMR'}->[0]\t$ASN_r{'AMR'}->{'h'}\t$ASN_r{'AMR'}->{'p'}\t$res{'EUR'}->[0]\t$ASN_r{'EUR'}->{'h'}\t$ASN_r{'EUR'}->{'p'}\t$res{'EAS'}->[0]\t$ASN_r{'EAS'}->{'h'}\t$ASN_r{'EAS'}->{'p'}\t$res{'SAS'}->[0]\t$ASN_r{'SAS'}->{'h'}\t$ASN_r{'SAS'}->{'p'}\n";
	}
}
close OA;
close IA;
