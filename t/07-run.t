#!perl

use strict;
use warnings;

use Test::More tests => 1;

use Kvasir::Declare;
use Kvasir::Writer::XML;

my $engine = engine {
    action "action1" => instanceof "Kvasir::Action";
    action "action2" => instanceof "Kvasir::Action";
    
    rule "rule1" => instanceof "Kvasir::Rule";
    rule "rule2" => instanceof "Kvasir::Rule";
    rule "rule3" => instanceof "Kvasir::Rule";
    rule "rule4" => instanceof "Kvasir::Rule";
    
    run "action1" => when qw(rule1 rule2 rule4);
    run "action2" => when qw(rule3);
    
    run "action2" => when qw(rule4);
};

my $xml = Kvasir::Writer::XML->as_xml($engine);
is($xml, q{<?xml version="1.0"?>
<engine>
  <action name="action1" instanceOf="Kvasir::Action"/>
  <action name="action2" instanceOf="Kvasir::Action"/>
  <rule name="rule1" instanceOf="Kvasir::Rule"/>
  <rule name="rule2" instanceOf="Kvasir::Rule"/>
  <rule name="rule3" instanceOf="Kvasir::Rule"/>
  <rule name="rule4" instanceOf="Kvasir::Rule"/>
  <run action="action1">
    <rule>rule1</rule>
    <rule>rule2</rule>
    <rule>rule4</rule>
  </run>
  <run action="action2">
    <rule>rule3</rule>
    <rule>rule4</rule>
  </run>
</engine>
});

