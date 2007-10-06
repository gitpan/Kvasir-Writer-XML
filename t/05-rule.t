#!perl

use strict;
use warnings;

use Test::More tests => 1;

use Kvasir::Declare;
use Kvasir::Writer::XML;

my $engine = engine {
    rule "rule1" => instanceof "Kvasir::Rule";
    rule "rule3" => instanceof "Kvasir::Rule";
    rule "rule2" => instanceof "Kvasir::Rule" => with_args {
        foo => 1,
        bar => 2,
    };
};

my $xml = Kvasir::Writer::XML->as_xml($engine);
is($xml, q{<?xml version="1.0"?>
<engine>
  <rule name="rule1" instanceOf="Kvasir::Rule"/>
  <rule name="rule3" instanceOf="Kvasir::Rule"/>
  <rule name="rule2" instanceOf="Kvasir::Rule">
    <bar>2</bar>
    <foo>1</foo>
  </rule>
</engine>
});

