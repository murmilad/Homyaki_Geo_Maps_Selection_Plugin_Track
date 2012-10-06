#
#===============================================================================
#
#         FILE: Abstract.pm
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
package Homyaki::Geo_Maps::Track_Parser::Abstract;

use strict;
 
sub new {
	my $this = shift;
	my %h = @_;

	my $source = $h{source};

	my $self = {};

	my $class = ref($this) || $this;
	bless $self, $class;

	$self->{source}      = $source;
	$self->{coordinates} = [];

	return $self;
}

sub is_actual_parser {
	my $this = shift;
	my %h    = @_;

	return 0;
}

sub parse {
	my $this = shift;
	my %h    = @_;
}

1;
