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
		Homyaki::Logger::print_log('Homyaki::Geo_Maps::Track_Parser::KML_1 hash = ' . Dumper($kml_hash));
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

		my @coordinates;

		my $nodes = []; 

		locate_nodes($this->{data}, 'coordinates', $nodes);

		foreach my $node (@{$nodes}){
			my @coordinates = split(/\n|\s+/, $node);
			if (scalar(@coordinates) > 1) {
				foreach my $coord_line (@coordinates) {
					if ($coord_line =~ /([-\d\.]+),([-\d\.]+)/){
						push(@{$this->{coordinates}}, [$1,$2]);
					}
				}
			}
		}
	}


#	Homyaki::Logger::print_log('Homyaki::Geo_Maps::Track_Parser::KML_1 this = ' . Dumper($this->{coordinates}));
}

sub locate_nodes {
	my $hash   = shift;
	my $node   = shift;
	my $result = shift || [];

	if (ref($hash) eq 'HASH'){
		foreach my $current_node (sort {
			my $dig_a;
			my $dig_b;

			$dig_a = $1 if $a =~ /(\d+)$/i;
			$dig_b = $1 if $b =~ /(\d+)$/i;

			if ($dig_a && $dig_b) {
				$dig_a <=> $dig_b
			} else {
				$a cmp $b
			}
		} keys %{$hash}) {
			if ($current_node eq $node) {
				push(@{$result}, $hash->{$current_node});
			} else {
				locate_nodes($hash->{$current_node}, $node, $result);
			}
		}
	}
}

1;
