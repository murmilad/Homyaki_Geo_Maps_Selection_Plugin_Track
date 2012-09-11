package Homyaki::HTML::Geo_Maps::Selection::Track;

use strict;

use Homyaki::Tag;
use Homyaki::HTML::Constants;

use constant NAME   => 'geo_track_upload';
use constant HEADER => 'Select by track';
sub get_interface {
	my $self = shift;
	my %h = @_;

	my $body_tag = $h{body_tag};

	$body_tag->add_form_element(
		type => &INPUT_TYPE_FILE,
		name => 'track_file',
	);

	$body_tag->add_form_element(
		type => &INPUT_TYPE_DIV,
		name => 'help',
		body => 'Please select a tack file.',
	);

}

1;
