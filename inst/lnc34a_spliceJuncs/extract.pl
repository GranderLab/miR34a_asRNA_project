#!/usr/bin/perl
#https://genome.ucsc.edu/cgi-bin/hgFileUi?db=hg19&g=wgEncodeCshlLongRnaSeq
use warnings;
use strict;
use Data::Dumper;

my $dir = './sampleFiles';
unless (-d $dir) {
    my $cmd1 = 'mkdir' . ' ' . $dir ;
    system($cmd1);
    
    my @downloadFiles = (
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeCshlLongRnaSeq/wgEncodeCshlLongRnaSeqA549CellPamJunctions.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeCshlLongRnaSeq/wgEncodeCshlLongRnaSeqA549CellPapJunctions.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeCshlLongRnaSeq/wgEncodeCshlLongRnaSeqAg04450CellPamJunctions.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeCshlLongRnaSeq/wgEncodeCshlLongRnaSeqAg04450CellPapJunctions.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeCshlLongRnaSeq/wgEncodeCshlLongRnaSeqBjCellPamJunctions.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeCshlLongRnaSeq/wgEncodeCshlLongRnaSeqBjCellPapJunctions.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeCshlLongRnaSeq/wgEncodeCshlLongRnaSeqCd20CellPamJunctions.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeCshlLongRnaSeq/wgEncodeCshlLongRnaSeqCd20CellPapJunctions.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeCshlLongRnaSeq/wgEncodeCshlLongRnaSeqCd34mobilizedCellTotalJunctions.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeCshlLongRnaSeq/wgEncodeCshlLongRnaSeqGm12878CellPamJunctions.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeCshlLongRnaSeq/wgEncodeCshlLongRnaSeqGm12878CellPapJunctions.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeCshlLongRnaSeq/wgEncodeCshlLongRnaSeqH1hescCellPamJunctions.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeCshlLongRnaSeq/wgEncodeCshlLongRnaSeqH1hescCellPapJunctions.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeCshlLongRnaSeq/wgEncodeCshlLongRnaSeqHaoafCellTotalJunctions.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeCshlLongRnaSeq/wgEncodeCshlLongRnaSeqHaoecCellTotalJunctions.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeCshlLongRnaSeq/wgEncodeCshlLongRnaSeqHchCellTotalJunctions.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeCshlLongRnaSeq/wgEncodeCshlLongRnaSeqHfdpcCellTotalJunctions.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeCshlLongRnaSeq/wgEncodeCshlLongRnaSeqHmecCellPamJunctions.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeCshlLongRnaSeq/wgEncodeCshlLongRnaSeqHmecCellPapJunctions.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeCshlLongRnaSeq/wgEncodeCshlLongRnaSeqHmepcCellTotalJunctions.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeCshlLongRnaSeq/wgEncodeCshlLongRnaSeqHobCellTotalJunctions.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeCshlLongRnaSeq/wgEncodeCshlLongRnaSeqHpcplCellTotalJunctions.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeCshlLongRnaSeq/wgEncodeCshlLongRnaSeqHpiepcCellTotalJunctions.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeCshlLongRnaSeq/wgEncodeCshlLongRnaSeqHsmmCellPamJunctions.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeCshlLongRnaSeq/wgEncodeCshlLongRnaSeqHsmmCellPapJunctions.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeCshlLongRnaSeq/wgEncodeCshlLongRnaSeqHsavecCellTotalJunctions.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeCshlLongRnaSeq/wgEncodeCshlLongRnaSeqHuvecCellPamJunctions.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeCshlLongRnaSeq/wgEncodeCshlLongRnaSeqHuvecCellPapJunctions.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeCshlLongRnaSeq/wgEncodeCshlLongRnaSeqHvmfCellTotalJunctions.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeCshlLongRnaSeq/wgEncodeCshlLongRnaSeqHwpCellTotalJunctions.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeCshlLongRnaSeq/wgEncodeCshlLongRnaSeqHelas3CellPamJunctions.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeCshlLongRnaSeq/wgEncodeCshlLongRnaSeqHelas3CellPapJunctions.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeCshlLongRnaSeq/wgEncodeCshlLongRnaSeqHepg2CellPamJunctions.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeCshlLongRnaSeq/wgEncodeCshlLongRnaSeqHepg2CellPapJunctions.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeCshlLongRnaSeq/wgEncodeCshlLongRnaSeqImr90CellPapJunctions.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeCshlLongRnaSeq/wgEncodeCshlLongRnaSeqImr90CellTotalJunctions.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeCshlLongRnaSeq/wgEncodeCshlLongRnaSeqK562CellPamJunctions.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeCshlLongRnaSeq/wgEncodeCshlLongRnaSeqK562CellPapJunctions.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeCshlLongRnaSeq/wgEncodeCshlLongRnaSeqMcf7CellPamJunctions.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeCshlLongRnaSeq/wgEncodeCshlLongRnaSeqMcf7CellPapJunctions.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeCshlLongRnaSeq/wgEncodeCshlLongRnaSeqMonocd14CellPamJunctions.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeCshlLongRnaSeq/wgEncodeCshlLongRnaSeqMonocd14CellPapJunctions.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeCshlLongRnaSeq/wgEncodeCshlLongRnaSeqNhdfCellTotalJunctions.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeCshlLongRnaSeq/wgEncodeCshlLongRnaSeqNhekCellPamJunctions.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeCshlLongRnaSeq/wgEncodeCshlLongRnaSeqNhekCellPapJunctions.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeCshlLongRnaSeq/wgEncodeCshlLongRnaSeqNhemfm2CellTotalJunctions.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeCshlLongRnaSeq/wgEncodeCshlLongRnaSeqNhemm2CellTotalJunctions.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeCshlLongRnaSeq/wgEncodeCshlLongRnaSeqNhlfCellPamJunctions.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeCshlLongRnaSeq/wgEncodeCshlLongRnaSeqNhlfCellPapJunctions.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeCshlLongRnaSeq/wgEncodeCshlLongRnaSeqSknshCellPapJunctions.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeCshlLongRnaSeq/wgEncodeCshlLongRnaSeqSkmcCellTotalJunctions.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeCshlLongRnaSeq/wgEncodeCshlLongRnaSeqHmncpbCellTotalJunctionsV2.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeCshlLongRnaSeq/wgEncodeCshlLongRnaSeqHmscatCellTotalJunctions.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeCshlLongRnaSeq/wgEncodeCshlLongRnaSeqHmscbmCellTotalJunctions.bedRnaElements.gz",
    "http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeCshlLongRnaSeq/wgEncodeCshlLongRnaSeqHmscucCellTotalJunctions.bedRnaElements.gz"
    );
    
    foreach my $dfile (@downloadFiles) {
        my $cmd2 = 'wget -P ./sampleFiles/'. ' ' . $dfile;
        system($cmd2);
    }
    
    my $unzipCmd = "gunzip " . $dir . "/*.gz";
    
}

my @files = glob( $dir . '/*' );

#open a output file
#run through each file in @files and extract reads in the right region and chr start 9241796   stop 9257102 strand +
#add them to a hash and count their occurences

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
        
        if($chr eq 'chr1' && $strand eq '+' && $start >= 9241796 && $stop <= 9257102) {
            $counts{$chr}{$strand}{$start}{$stop}++;
            print $f $file . "\t" . $_ . "\n";
        }

    }
}

#re-run through the hash and print to the output all reads with more than 2 occurences
open(my $fh, ">", "output.bedRnaElements") or die "Can't open > output.bedRnaElements: $!";


foreach my $c (keys %counts) {
    foreach my $strnd (keys $counts{$c}) {
        foreach my $strt (keys $counts{$c}{$strnd}) {
            foreach my $stp (keys $counts{$c}{$strnd}{$strt}) {
                if($counts{$c}{$strnd}{$strt}{$stp} > 2) {
                    print $fh "$c\t$strnd\t$strt\t$stp\t$counts{$c}{$strnd}{$strt}{$stp}\n";
                }
            }
        }
    }
}
#print Dumper \%counts;





