#!/usr/bin/perl

use Test::More tests => 2;
use Test::Script;

my %options;
$options{exit} = 255;

script_compiles('expect.pl');
script_runs(['expect.pl'], \%options);
