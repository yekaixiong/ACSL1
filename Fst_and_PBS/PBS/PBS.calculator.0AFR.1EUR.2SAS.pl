#!/usr/bin/perl
use strict;
use warnings;

## This program is to calculate PBS from three pairs of Fst;
## Programmer : yekaixiong

## ^ is not a symbol in perl, rather I should use **
die "Usage:<input of chrmosome number>" unless @ARGV == 1 ;

my $chr = "chr" . $ARGV[0];
my $dir = ".";

my $file1 = $chr.".AFR_EUR.Fst.example";
my $file2 = $chr.".AFR_SAS.Fst.example";
my $file3 = $chr.".EUR_SAS.Fst.example";

close IA;
my $outfile="$chr.0AFR.1EUR.2SAS.PBS";

open IA, "$dir/AFR_EUR/$file1"  || die "Can't open IA: $!\n";
my %T01;
while (<IA>) {
	chomp;
	my @tmp = split;
	my $ID  = $tmp[0] . "_" . $tmp[1];
	my $fst = $tmp[-1];
	$fst    = 0 if ($fst < 0);
	print "1:$_\n" if ($fst == 1);
	if($fst == 1){
		$T01{$ID}  = -log(1e-10);
	}else{
		$T01{$ID}  = -log(1-$fst);
	}
}
close IA;

my %T02;
open IA, "$dir/AFR_SAS/$file2" || die "IA:$!\n";
while(<IA>){
        chomp;
        my @tmp = split;
        my $ID  = $tmp[0] . "_" . $tmp[1];
        my $fst = $tmp[-1];
        $fst    = 0 if ($fst < 0);
	print "2:$_\n" if ($fst == 1);
	if($fst == 1){
        	$T02{$ID}  = -log(1e-10);	
	}else{
		$T02{$ID}  = -log(1-$fst);
	}
}
close IA;

open IA, "$dir/EUR_SAS/$file3" || die "IA:$!\n";
open OA, ">$outfile" || die "OA:$!\n";
print OA "CHR\tPOS\tID\tAFR\tEUR\tSAS\n";
while(<IA>){
        chomp;
        my @tmp = split;
        my $ID  = $tmp[0] . "_" . $tmp[1];
	next unless (defined $T01{$ID} && defined $T02{$ID});
        my $fst = $tmp[-1];
	print "3:$_\n" if ($fst == 1);
        $fst    = 0 if ($fst < 0);
        my $t12;
	if($fst == 1){
		$t12 =  -log(1e-10);
	}else{
		$t12 =  -log(1-$fst);
	}
	my $t01 = $T01{$ID};
	my $t02 = $T02{$ID};
	my $PBS1  = ($t01+$t12-$t02) / 2;
	my $PBS2  = ($t02+$t12-$t01) / 2;
	my $PBS0  = ($t01+$t02-$t12) / 2;
	print OA "$tmp[0]\t$tmp[1]\t$tmp[2]\t$PBS0\t$PBS1\t$PBS2\n";
}
close IA;
close OA;

