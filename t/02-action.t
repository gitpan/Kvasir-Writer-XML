#!perl

use strict;
use warnings;

use Test::More tests => 1;

use Kvasir::Declare;
use Kvasir::Writer::XML;

my $engine = engine {
    action "action2" => instanceof "Kvasir::Action" => with_args {
        foo => 1,
        bar => 2,
    };

    action "action1" => instanceof "Kvasir::Action";
};

my $xml = Kvasir::Writer::XML->as_xml($engine);
is($xml, q{<?xml version="1.0"?>
<engine>
  <action name="action1" instanceOf="Kvasir::Action"/>
  <action name="action2" instanceOf="Kvasir::Action">
    <bar>2</bar>
    <foo>1</foo>
  </action>
</engine>
});

