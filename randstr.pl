#!/usr/bin/env perl
use strict;
use warnings;
use feature 'say';

use Time::Piece;
use Digest::SHA;


my $opt = $ARGV[0] // '';
my $num = $ARGV[1] // 100;

if ($opt =~ /\A(d|w|dw|wd|lw|uw)\z/) {
    $opt = $1;
}
elsif ($opt =~ /\A(\d+)\z/) {
    $num = $1;
}

if ($num > 1000) {
    $num = 1000;
}
elsif ($num <= 0) {
    $num = 100;
}

my $i = 0;
my $round = 100;
my $epoch = localtime->epoch;
my $sha1;
my @sha1s;

while ($i <= $round) {
    $epoch++;
    $sha1 = Digest::SHA::sha1_base64($epoch);
    push @sha1s, $sha1;
    $i++;
}

my $sha1s = join "", @sha1s;
my @chop = split //, $sha1s;

if ($opt eq 'w') {
    my @words =  grep {/[a-zA-Z]/} @chop;
    @chop = @words;
}
elsif ($opt =~ /(dw|wd)/) {
    my @words =  grep {/[a-zA-Z\d]/} @chop;
    @chop = @words;
}
elsif ($opt eq 'd') {
    my @digit =  grep {/\d/} @chop;
    while ($#digit < $num) {
        my @tigid = reverse @digit;
        @digit = (@digit, @tigid);
    }
    @chop = @digit;
}
elsif ($opt eq 'uw') {
    my $uc = uc $sha1s;
    my @chop_uc = split //, $uc;
    my @words_uc =  grep {/[a-zA-Z]/} @chop_uc;
    @chop = @words_uc;
}
elsif ($opt eq 'lw') {
    my $lc = lc $sha1s;
    my @chop_lc = split //, $lc;
    my @words_lc =  grep {/[a-zA-Z]/} @chop_lc;
    @chop = @words_lc;
}

my @result;
my $count = 0;
while ($count < $num) {
    push @result, $chop[$count];
    $count++;
}
print @result;