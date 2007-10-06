#!perl

use strict;
use warnings;

use Test::More tests => 1;

use Kvasir::Declare;
use Kvasir::Writer::XML;

my $engine = engine {
    input "input2" => instanceof "Kvasir::Input" => with_args {
        foo => 1,
        bar => 2,
    };

    input "input1" => instanceof "Kvasir::Input";
};

my $xml = Kvasir::Writer::XML->as_xml($engine);
is($xml, q{<?xml version="1.0"?>
<engine>
  <input name="input1" instanceOf="Kvasir::Input"/>
  <input name="input2" instanceOf="Kvasir::Input">
    <bar>2</bar>
    <foo>1</foo>
  </input>
</engine>
});

