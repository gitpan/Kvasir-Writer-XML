#!perl

use strict;
use warnings;

use Test::More tests => 1;

use Kvasir::Declare;
use Kvasir::Writer::XML;

my $engine = engine {
    output "output2" => instanceof "Kvasir::Output" => with_args {
        foo => 1,
        bar => 2,
    };

    output "output1" => instanceof "Kvasir::Output";
};

my $xml = Kvasir::Writer::XML->as_xml($engine);
is($xml, q{<?xml version="1.0"?>
<engine>
  <output name="output1" instanceOf="Kvasir::Output"/>
  <output name="output2" instanceOf="Kvasir::Output">
    <bar>2</bar>
    <foo>1</foo>
  </output>
</engine>
});

