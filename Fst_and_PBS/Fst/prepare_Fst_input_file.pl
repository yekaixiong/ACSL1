#!/usr/bin/perl
use strict;
use warnings;

## Programmer : yekaixiong

## ^ is not a symbol in perl, rather I should use **
die "Usage:<input><pop1 code><pop2 code>" unless @ARGV == 3;

my %population = ("AFR"=>1, "AMR"=>2, "EUR"=>3, "EAS"=>4, "SAS"=>5);

die "$ARGV[1] is not a valid population\n" unless (defined $population{$ARGV[1]});
die "$ARGV[2] is not a valid population\n" unless (defined $population{$ARGV[2]});
my @names   = split /\//, $ARGV[0];
my $basename= $names[-1];
my $outfile = $basename . ".$ARGV[1]" . "_$ARGV[2]";


my $index1 = $population{$ARGV[1]};
my $index2 = $population{$ARGV[2]};

my $idx0   = ($index1 + 1) * 3 - 1;
my $idx1   = ($index1 + 1) * 3; 
my $idx2   = ($index1 + 1) * 3 + 1;

my $idx3   = ($index2 + 1) * 3 - 1;
my $idx4   = ($index2 + 1) * 3;
my $idx5   = ($index2 + 1) * 3 + 1;


open IA, "$ARGV[0]"  || die "Can't open IA: $!\n";
open OA, ">$outfile" || die "OA:$!\n";
my %hash;
while (<IA>) {
	chomp;
	my @tmp = split;
	next if ($tmp[$idx2] eq "NA" || $tmp[$idx5] eq "NA");
	next if ($tmp[$idx2] == 0 && $tmp[$idx5] == 0);
	next if ($tmp[$idx2] == 1 && $tmp[$idx5] == 1);
	next if ($tmp[$idx0] <=10 || $tmp[$idx3]<=10); ## Removed sites with small number of haplotype
   	my @new = @tmp[0,1,2,3,4,$idx0,$idx2,$idx3,$idx5];
	$new[-2] = $new[-2]*2;
	$new[-4] = $new[-4]*2;
	my $line= join "\t", @new;
	print OA "$line\n";
}

close IA;
close OA;
