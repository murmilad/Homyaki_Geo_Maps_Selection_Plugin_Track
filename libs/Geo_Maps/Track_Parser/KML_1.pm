#
#===============================================================================
#
#         FILE: KML_1.pm
#
#  DESCRIPTION: Track parser abstract module
#
#        FILES: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: Alexey Kosarev (Murmilad), 
#      COMPANY: 
#      VERSION: 1.0
#      CREATED: 06.10.2012 15:15:31
#     REVISION: ---
#===============================================================================
package Homyaki::Geo_Maps::Track_Parser::KML_1;

use strict;

use base 'Homyaki::Geo_Maps::Track_Parser::Abstract';

use XML::Simple;

use Homyaki::Logger;
use Data::Dumper;
 
sub is_actual_parser {
	my $this = shift;
	my %h    = @_;

	if (my $kml_hash = XMLin($this->{source})){
#		Homyaki::Logger::print_log('Homyaki::Geo_Maps::Track_Parser::KML_1 hash = ' . Dumper($kml_hash));
		if ($kml_hash->{xmlns} =~ /\/kml\/2\./i){
			$this->{data} = $kml_hash;
			return 1;
		}
	}

	return 0;
}

sub parse {
	my $this = shift;
	my %h    = @_;

	if ($this->{data}){
		my $coordinates_str = $this->{data}->{Document}->{Placemark}->{LineString}->{coordinates};
		my @coordinates;
		foreach my $coord_line (split("\n", $coordinates_str)) {
			if ($coord_line =~ /([-\d\.]+),([-\d\.]+)/){
				push(@coordinates, [$1,$2]);
			}
		}
	
		if (scalar(@coordinates) > 0) {
			push(@{$this->{coordinates}}, (@coordinates));
		}
	}


#	Homyaki::Logger::print_log('Homyaki::Geo_Maps::Track_Parser::KML_1 this = ' . Dumper($this));
}

1;
