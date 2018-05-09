#!/usr/bin/perl

use strict;
use Expect;

die "Usage: $0 cmd [-echo] expect1 send1 expect2 send2 ...\n"
    unless @ARGV;

my $cmd = shift @ARGV;

my $exp = Expect->spawn($cmd)
    or die "Cannot spawn $cmd: $!\n";

if ($ARGV[0] eq '-echo') {
    shift @ARGV;
    $exp->slave->stty(qw(-echo));
    $exp->log_stdout(0);
}

while (@ARGV) {
    my $expect = shift @ARGV;
    $exp->expect(30, $expect) or die "Cannot expect $expect\n";
    my $send = shift @ARGV;
    $exp->send(My::interpolate($send));
    $exp->exp_continue;
}

$exp->interact();


sub My::interpolate {
    local $_ = shift;
    return eval "qq($_)";
}
