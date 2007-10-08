#!perl

package Test::Kvasir::Input;

use strict;
use warnings;

use Test::More tests => 5;

use Kvasir::Declare;
use Kvasir::Writer::XML;

use base qw(Kvasir::Input);

sub process_xml_writer_args {
    my ($self, $doc, $parent, %args) = @_;
    
    is($self, "Test::Kvasir::Input");
    isa_ok($doc, "XML::LibXML::Document");
    isa_ok($parent, "XML::LibXML::Element");
    is_deeply(\%args, { foo => 1, bar => 2 });
    
    $parent->appendText("foo");
}

my $engine = engine {
    input "input1" => instanceof "Test::Kvasir::Input" => with_args {
        foo => 1,
        bar => 2,
    };
};

my $as_xml = Kvasir::Writer::XML->as_xml($engine);

is($as_xml, q{<?xml version="1.0"?>
<engine>
  <input name="input1" instanceOf="Test::Kvasir::Input">foo</input>
</engine>
});