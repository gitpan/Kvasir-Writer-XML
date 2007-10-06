#!perl

use strict;
use warnings;

use Test::More tests => 1;

use Kvasir::Declare;
use Kvasir::Writer::XML;

my $engine = engine {
    prehook "hook1" => instanceof "Kvasir::Hook";
    posthook "hook2" => instanceof "Kvasir::Hook";

    prehook "hook3" => instanceof "Kvasir::Hook";
    posthook "hook4" => instanceof "Kvasir::Hook";
};

my $xml = Kvasir::Writer::XML->as_xml($engine);
is($xml, q{<?xml version="1.0"?>
<engine>
  <prehook name="hook1" instanceOf="Kvasir::Hook"/>
  <prehook name="hook3" instanceOf="Kvasir::Hook"/>
  <posthook name="hook2" instanceOf="Kvasir::Hook"/>
  <posthook name="hook4" instanceOf="Kvasir::Hook"/>
</engine>
});

