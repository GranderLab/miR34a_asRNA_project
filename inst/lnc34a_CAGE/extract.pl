#!/usr/bin/perl
#https://genome.ucsc.edu/cgi-bin/hgFileUi?db=hg19&g=wgEncodeCshlLongRnaSeq
use warnings;
use strict;
use Data::Dumper;

my $dir = $ARGV[0];
unless (-d $dir) {
    my $cmd1 = 'mkdir' . ' ' . $dir ;
    system($cmd1);
    
    my @downloadFiles = (
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeRikenCage/wgEncodeRikenCageA549CellPapTssHmm.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeRikenCage/wgEncodeRikenCageAg04450CellPapTssHmm.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeRikenCage/wgEncodeRikenCageBjCellPapTssHmm.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeRikenCage/wgEncodeRikenCageCd20CellPapTssHmm.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeRikenCage/wgEncodeRikenCageCd34mobilizedCellPapTssHmm.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeRikenCage/wgEncodeRikenCageGm12878CellPapTssHmm.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeRikenCage/wgEncodeRikenCageH1hescCellPamTssHmmV2.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeRikenCage/wgEncodeRikenCageH1hescCellPapTssHmm.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeRikenCage/wgEncodeRikenCageHaoafCellPapTssHmm.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeRikenCage/wgEncodeRikenCageHaoecCellPapTssHmm.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeRikenCage/wgEncodeRikenCageHchCellPapTssHmm.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeRikenCage/wgEncodeRikenCageHfdpcCellPapTssHmm.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeRikenCage/wgEncodeRikenCageHmepcCellPapTssHmm.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeRikenCage/wgEncodeRikenCageHobCellPapTssHmm.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeRikenCage/wgEncodeRikenCageHpcplCellPapTssHmm.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeRikenCage/wgEncodeRikenCageHpiepcCellPapTssHmm.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeRikenCage/wgEncodeRikenCageHsavecCellPapTssHmm.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeRikenCage/wgEncodeRikenCageHuvecCellPapTssHmm.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeRikenCage/wgEncodeRikenCageHvmfCellPapTssHmm.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeRikenCage/wgEncodeRikenCageHwpCellPapTssHmm.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeRikenCage/wgEncodeRikenCageHelas3CellPapTssHmm.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeRikenCage/wgEncodeRikenCageHepg2CellPapTssHmmV2.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeRikenCage/wgEncodeRikenCageImr90CellPapTssHmm.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeRikenCage/wgEncodeRikenCageK562CellPapTssHmm.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeRikenCage/wgEncodeRikenCageMcf7CellPapTssHmm.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeRikenCage/wgEncodeRikenCageMonocd14CellPapTssHmm.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeRikenCage/wgEncodeRikenCageNhdfCellPapTssHmm.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeRikenCage/wgEncodeRikenCageNhekCellPapTssHmm.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeRikenCage/wgEncodeRikenCageNhemfm2CellPapTssHmm.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeRikenCage/wgEncodeRikenCageNhemm2CellPapTssHmm.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeRikenCage/wgEncodeRikenCageSknshCellPapTssHmm.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeRikenCage/wgEncodeRikenCageSknshraCellPapTssHmm.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeRikenCage/wgEncodeRikenCageSkmcCellPapTssHmm.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeRikenCage/wgEncodeRikenCageHmscatCellPapTssHmm.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeRikenCage/wgEncodeRikenCageHmscbmCellPapTssHmm.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeRikenCage/wgEncodeRikenCageHmscucCellPapTssHmm.bedRnaElements.gz"
    );
    
    foreach my $dfile (@downloadFiles) {
        my $cmd2 = 'wget -P ./sampleFiles/'. ' ' . $dfile;
        system($cmd2);
    }
    
    my $unzipCmd = "gunzip " . $dir . "/*.gz";
    system($unzipCmd);
}

my @files = glob( $dir . '/*' );




open(my $f, ">", "fileResults.txt") or die "Can't open > fileResults.txt: $!";
my %counts;

foreach my $file (@files) {
    open(my $fi, "<", $file) or die "Can't open > input: $!";
    while ( <$fi> ) {
        chomp;
        my @tmp = split /\t/,;
        my $chr = $tmp[0];
        my $strand = $tmp[5];
        my $start = $tmp[1];
        my $stop = $tmp[2];
        my $pvalue = $tmp[7];
        
        if($chr eq 'chr1' && $strand eq '+' && $start >= (9241796 - 200) && $stop <= (9242263 + 200)) {
            my $assignment = "NA";
            if($start > (9241796 - 200) && $start < (9241796 + 200)) {
                $assignment = "lnc34a"
            }
            if($start > (9242263 - 200) && $start < (9242263 + 200)) {
               $assignment = "miR34aAS"
            }
            #$counts{$chr}{$strand}{$start}{$stop}++;
            if($pvalue < 0.05 && $pvalue != -1) {
                print $f $file . "\t" . $_ . "\t" . $assignment . "\n";
            }
        }
        
    }
}



