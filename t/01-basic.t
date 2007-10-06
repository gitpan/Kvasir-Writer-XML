#!perl

use strict;
use warnings;

use Test::More tests => 7;
use Test::Exception;

use File::Temp qw(tmpnam);
use Kvasir::Declare;

BEGIN { use_ok('Kvasir::Writer::XML') };

my $engine = engine {};

my $xml = Kvasir::Writer::XML->as_xml($engine);
is($xml, q{<?xml version="1.0"?>
<engine/>
});

my $path = tmpnam();

ok(!-e $path);
lives_ok {
    Kvasir::Writer::XML->to_file($engine, $path);
};
ok(-e $path);
unlink $path;

throws_ok {
    Kvasir::Writer::XML->as_xml(undef);
} qr/Engine is undefined/;

throws_ok {
    Kvasir::Writer::XML->as_xml("");
} qr/Not a Kvasir::Engine instance/;
