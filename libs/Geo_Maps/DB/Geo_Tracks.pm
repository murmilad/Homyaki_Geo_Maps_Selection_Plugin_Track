package Homyaki::Geo_Maps::DB::Geo_Tracks;

use strict;
use base 'Homyaki::Geo_Maps::DB';

__PACKAGE__->table('geo_tracks');
__PACKAGE__->columns(Primary   => qw/id/);
__PACKAGE__->columns(Essential => qw/ip_address track_file_body track_file_name track_file_mime/);

sub find_or_create {
        my $class  = shift;
        my $params = shift;

        my $self = $class->SUPER::find_or_create($params);

	return $self;
}


1;
