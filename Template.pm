package MyApp::Email::Template;

use Moose;
use utf8;
use Carp qw(croak);
use English qw($EVAL_ERROR -no_match_vars);

use namespace::autoclean;
use Moose::Util::TypeConstraints;
#----------------------------------------------------------------------------------#
# central email template generator
#----------------------------------------------------------------------------------#
#----------------------------------------------------------------------------------#
# custom module                                                                    #
#----------------------------------------------------------------------------------#
use MyApp::Email::Template::EmailVerification;
use MyApp::Email::Template::Welcome;
use MyApp::Email::Template::PasswordReset;
use MyApp::Email::Template::Promotion;
use MyApp::Utils;
#----------------------------------------------------------------------------------#
#----------------------------------------------------------------------------------#
#remove later
use Data::Dumper;


#----------------------------------------------------------------------------------#
#----------------------------------------------------------------------------------#
enum 'email_template' => [ 'email_verification', 'welcome', 'password_reset', 'promotion' ];

has 'template'       => ( is => 'rw', isa => 'email_template', required => 1 );

#----------------------------------------------------------------------------------#
#----------------------------------------------------------------------------------#
has 'conf' => (
    is            => 'ro',
    isa           => 'HashRef',
    default       => sub { MyApp::utils->new->fetch_all_config->{server_config}->{email_template_conf} },
    lazy          => 1,
);
#----------------------------------------------------------------------------------#
#----------------------------------------------------------------------------------#
has 'email_verification' => (
    is            => 'ro',
    isa           => 'MyApp::Email::Template::EmailVerification',
    default       => sub { MyApp::Email::Template::EmailVerification->new },
    lazy          => 1,
);

#----------------------------------------------------------------------------------#
#----------------------------------------------------------------------------------#
has 'welcome' => (
    is            => 'ro',
    isa           => 'MyApp::Email::Template::Welcome',
    default       => sub { MyApp::Email::Template::Welcome->new },
    lazy          => 1,
);

#----------------------------------------------------------------------------------#
#----------------------------------------------------------------------------------#
has 'password_reset' => (
    is            => 'ro',
    isa           => 'MyApp::Email::Template::PasswordReset',
    default       => sub { MyApp::Email::Template::PasswordReset->new },
    lazy          => 1,
    documentation => 'This variable will have object of MyApp::Email::Template::PasswordReset',
);

#----------------------------------------------------------------------------------#
#----------------------------------------------------------------------------------#
has 'promotion' => (
    is            => 'ro',
    isa           => 'MyApp::Email::Template::Promotion',
    default       => sub { MyApp::Email::Template::Promotion->new },
    lazy          => 1,
);

#----------------------------------------------------------------------------------#
#----------------------------------------------------------------------------------#

sub get_template {
    my ( $self, $data ) = @_;

    my $template = $self->template;
    my $conf     = $self->conf;
    my ($email_body , $subject);

    eval {
        ($email_body , $subject) = $self->$template->build_template( $data, $conf);
        1;
    } or do {
        croak "Error occured while calling email '$template' $EVAL_ERROR\n";
    };

    return ($email_body , $subject);
}

#----------------------------------------------------------------------------------#
#----------------------------------------------------------------------------------#

__PACKAGE__->meta->make_immutable;

#----------------------------------------------------------------------------------#
#----------------------------------------------------------------------------------#

1;
