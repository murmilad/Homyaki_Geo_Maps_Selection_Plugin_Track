package Homyaki::Geo_Maps::Selection::Track;

use strict;

use Math::Geometry::Planar;
use Data::Dumper;

use Homyaki::Logger;
use Homyaki::Geo_Maps::Track_Parser;

sub set_vertexes {
	my $self = shift;
	my %h = @_;

	my $params = $h{params};

	if ($params->{track_file}) {
		my $track_file;
		my $file_handler = $params->{track_file}->{file_handler};
		while (my $line = <$file_handler>){
			$track_file .= $line;
		}
		my $track = Homyaki::Geo_Maps::Track_Parser->parse_track(
			source => $track_file
		);

		if ($track && scalar($track->{coordinates}) > 0) {
			foreach my $param (grep {$_ =~ /vertex_(\d+)_(lat|lng)/} keys %{$params}){
				delete $params->{$param};
			}

			my $planar_track_contour = Math::Geometry::Planar->new;
			$planar_track_contour->points($track->{coordinates});

			my $i;
			for ($i = 1; $i < scalar(@{$track->{coordinates}}); $i++) {
				$params->{"vertex_${i}_lat"} = $track->{coordinates}->[$i-1]->[1];
				$params->{"vertex_${i}_lng"} = $track->{coordinates}->[$i-1]->[0];
			}
			for (my $j = scalar(@{$track->{coordinates}}); $j > 0; $j--) {
				$i++;
				$params->{"vertex_${i}_lat"} = $track->{coordinates}->[$j-1]->[1] - 0.00003;
				$params->{"vertex_${i}_lng"} = $track->{coordinates}->[$j-1]->[0] - 0.00003;
			}

			my $bbox = $planar_track_contour->bbox();
			if ($bbox){
				my $bbox_points = $bbox->points;
				
				my $dounded_box = Math::Geometry::Planar->new;
				$dounded_box->points($bbox_points);
				my $bounded_center = $dounded_box->centroid;
			
				$params->{map_center_lat} = $bounded_center->[1];
				$params->{map_center_lng} = $bounded_center->[0];
				$params->{bounds_sw_lat} = $bbox_points->[0]->[1];
				$params->{bounds_sw_lng} = $bbox_points->[0]->[0];
				$params->{bounds_ne_lat} = $bbox_points->[3]->[1];
				$params->{bounds_ne_lng} = $bbox_points->[3]->[0];
			}
			
		}
#		Homyaki::Logger::print_log("Homyaki::Geo_Mas::Selection::Track file = $track_file");
		#vertex_(\d+)_(lat|lng)	
	}
}

1;
