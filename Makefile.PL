#!/usr/bin/env perl

# Copyright (C) 2009, Viacheslav Tykhanovskyi

use 5.008001;

use strict;
use warnings;

use ExtUtils::MakeMaker;

my $mm = $ExtUtils::MakeMaker::VERSION;

WriteMakefile(
    NAME         => 'Bootylicious::Plugin::GoogleAnalytics',
    VERSION_FROM => 'lib/Bootylicious/Plugin/GoogleAnalytics.pm',
    ABSTRACT     => 'Google Analytics plugin for bootyliciuos',
    AUTHOR       => 'Viacheslav Tykhanovskyi <vti@cpan.org>',

    ($mm < 6.3002 ? () : ('LICENSE' => 'artistic_2')),

    (   $mm < 6.46
        ? ()
        : ( META_MERGE => {
                requires  => {perl => '5.008001'},
                resources => {
                    homepage => 'http://getbootylicious.org',
                    license  => 'http://dev.perl.org/licenses/',
                    repository =>
                      'http://github.com/vti/bootylicious-plugin-google_analytics/tree/master'
                },
                no_index => {directory => [qw/t/]}
            },
            META_ADD => {
                build_requires     => {},
                configure_requires => {}
            },
        )
    ),

    PREREQ_PM => {
        'Bootylicious' => '0.910101'
    },
    test => {TESTS => 't/*.t t/*/*.t t/*/*/*.t t/*/*/*/*.t'}
);

1;
