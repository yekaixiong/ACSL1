#!/usr/bin/perl
use strict;
use warnings;

## This program is to calculat Fst for each SNP using Hudson's estimator;
## Date : 2015.11.18
## Programmer : yekaixiong

## ^ is not a symbol in perl, rather I should use **
die "Usage:<input><output>" unless @ARGV == 2;


open IA, "$ARGV[0]"  || die "Can't open IA: $!\n";
open OA, ">$ARGV[1]" || die "OA:$!\n";
my %hash;
while (<IA>) {
	chomp;
	my @tmp = split;
   	my $n1  = $tmp[5];
	my $n2  = $tmp[7];
	my $p1  = $tmp[6];
	my $p2  = $tmp[8];
	if($n1 == 1 || $n2 == 1){
		print "This locus has a sample size of only 1, and should be removed:\n";
		print "$_\n";
		die;
	}
	my $numerator   = ($p1 - $p2)**2 - $p1 * (1-$p1) / ($n1 - 1) - $p2* (1-$p2) / ($n2-1);
	my $denominator =  $p1 * (1-$p2) + $p2 * (1-$p1);
	if ($denominator == 0){
		print "This locus is not a SNP:\n";
		print "$_\n";
		die;
	}
	my $Fst         = $numerator / $denominator; 
	print OA "$tmp[0]\t$tmp[1]\t$tmp[2]\t$Fst\n";
}
close OA;
close IA;
