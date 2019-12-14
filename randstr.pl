#!/usr/bin/env perl
use strict;
use warnings;
use feature 'say';

use Time::Piece;
use Digest::SHA;
use Getopt::Long qw(:config posix_default no_ignore_case gnu_compat);
use Pod::Usage;

my $opts = {};

GetOptions(
    $opts => qw(
        digit|d
        word|w
        mix|m
        lower|l
        upper|u
        help|h
    ),
);
pod2usage if ($opts->{help});

my $d = $opts->{digit};
my $w = $opts->{word};
my $m = $opts->{mix};
my $l = $opts->{lower};
my $u = $opts->{upper};

my $opt = $ARGV[0] // '';
my $num = $ARGV[1] // 100;

$num = $d if $d;

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

if ($w) {
    my @words =  grep {/[a-zA-Z]/} @chop;
    @chop = @words;
}
elsif ($m) {
    my @words =  grep {/[a-zA-Z\d]/} @chop;
    @chop = @words;
}
elsif ($d) {
    my @digit =  grep {/\d/} @chop;
    while ($#digit < $num) {
        my @tigid = reverse @digit;
        @digit = (@digit, @tigid);
    }
    @chop = @digit;
}
elsif ($u) {
    my $uc = uc $sha1s;
    my @chop_uc = split //, $uc;
    my @words_uc =  grep {/[a-zA-Z]/} @chop_uc;
    @chop = @words_uc;
}
elsif ($l) {
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


__END__
=head1 SYNOPSIS

perl randstr.pl [options] [num]

Options:

  -d --digit           Set digit
  -w --word            Set words
  -m --mix             Set digit & words
  -l --lower           Set lower case
  -u --upper           Set upper case
  -h --help            Show help