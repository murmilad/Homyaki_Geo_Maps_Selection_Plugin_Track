#
#===============================================================================
#
#         FILE: Factory.pm
#
#  DESCRIPTION: Track parser factory
#
#        FILES: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: ALexey Kosarev (Murmilad), 
#      COMPANY: 
#      VERSION: 1.0
#      CREATED: 06.10.2012 15:06:19
#     REVISION: ---
#===============================================================================
package Homyaki::Geo_Maps::Track_Parser::Factory; 

use strict;

use base 'Homyaki::Factory';

use constant TRACK_PARSER_MAP => {
	kml_1 => 'Homyaki::Geo_Maps::Track_Parser::KML_1'
};


sub get_prack_parser {
	my $class = shift;

	my %h = @_;

	my $handler = $h{handler};
	my $source  = $h{source};

	my $parser;
	if (&TRACK_PARSER_MAP->{$handler}){
		$class->require_handler(&TRACK_PARSER_MAP->{$handler});
		$parser = &TRACK_PARSER_MAP->{$handler}->new(source => $source);
	}

	return $parser;
}
1;
