package MyApp::Email::Template::Common;

use Moose;
use utf8;

use namespace::autoclean;
#----------------------------------------------------------------------------------#
#----------------------------------------------------------------------------------#
#----------------------------------------------------------------------------------#
# custom module                                                                    #
#----------------------------------------------------------------------------------#
#----------------------------------------------------------------------------------#
#----------------------------------------------------------------------------------#
#remove later
use Data::Dumper;

#----------------------------------------------------------------------------------#
#----------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------#
#----------------------------------------------------------------------------------#

sub header {
    my ( $self, $data,$conf) = @_;

    my $header = <<HEADER_TEMPLATE;


 TEST HEADER



HEADER_TEMPLATE


    return $header;
}
#----------------------------------------------------------------------------------#
# template goes here
#----------------------------------------------------------------------------------#
sub footer {
    my ( $self, $data, $conf ) = @_;


    my $footer = <<FOOTER_TEMPLATE;



TEST FOOTER



FOOTER_TEMPLATE


    return $footer;

}
#----------------------------------------------------------------------------------#
#----------------------------------------------------------------------------------#

__PACKAGE__->meta->make_immutable;

#----------------------------------------------------------------------------------#
#----------------------------------------------------------------------------------#

1;
