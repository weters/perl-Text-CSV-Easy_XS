#!/usr/bin/env perl
use strict;
use warnings FATAL => 'all';
use 5.010;

use Test::Deep;
use Test::More;

use Text::CSV::Easy_XS qw(csv_parse);

test_values(
    q{abc,def,ghi}               => [qw( abc def ghi )],
    q{"abc","def","ghi"}         => [qw( abc def ghi )],
    q{"abc","""def""","ghi"}     => [qw( abc "def" ghi )],
    q{1,2,3}                     => [qw( 1 2 3 )],
    qq{abc,def\n}                => [qw( abc def )],
    q{abc , def , ghi}           => [ 'abc ', ' def ', ' ghi' ],
    q{abc,def,"g, ""h"", and i"} => [ 'abc', 'def', 'g, "h", and i' ],
    q{,""} => [ undef, '' ],
);

test_exceptions(
    q{1,ab"c}      => qr/quote found in middle of the field: ab"c/,
    q{1, "bad"}    => qr/quote found in middle of the field:  "bad"/,
    q{1,"}         => qr/unterminated string: 1,"/,
    qq{abc,de\nfg} => qr/newline found in unquoted string: de\nfg/,
    q{"ab"cd,2}    => qr/invalid field: "ab"cd,2/,
);

done_testing();

sub test_values {
    my %tests = @_;
    while ( my ( $csv, $expects ) = each %tests ) {
        ( my $csv_clean = $csv ) =~ s/\n/\\n/g;
        my $tmp =
          cmp_deeply( [ csv_parse($csv) ], $expects, "$csv_clean parses" );
        if ( !$tmp ) {
            use Data::Dumper;
            warn Dumper [ csv_parse($csv) ];
        }
    }
}

sub test_exceptions {
    my %tests = @_;

    while ( my ( $csv, $qr ) = each %tests ) {
        eval { csv_parse($csv) };
        ( my $csv_clean = $csv ) =~ s/\n/\\n/g;
        like( $@, $qr, "$csv_clean raised exception" );
    }
}
