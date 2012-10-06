#
#===============================================================================
#
#         FILE: Track_Parser.pm
#
#  DESCRIPTION: Parse geo track files
#
#        FILES: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: ALexey Kosarev (Murmilad), 
#      COMPANY: 
#      VERSION: 1.0
#      CREATED: 06.10.2012 14:55:45
#     REVISION: ---
#===============================================================================
package Homyaki::Geo_Maps::Track_Parser;

use strict;
 
use Homyaki::Geo_Maps::Track_Parser::Factory;

use constant TRACK_PARSERS => [
	'kml_1'
];

sub parse_track {
	my $class = shift;

	my %h = @_;

	my $source = $h{source};

	foreach my $parser_handler (@{&TRACK_PARSERS}){
		my $parser = Homyaki::Geo_Maps::Track_Parser::Factory->get_prack_parser(
			handler => $parser_handler,
			source  => $source,
		);
		if ($parser && $parser->is_actual_parser()){
			$parser->parse();
			return $parser;
		}
	}
}

1;
