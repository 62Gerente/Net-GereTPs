package Net::GereTPs::V1::Session;

use 5.012000;
use strict;
use warnings;
use WWW::Curl::Easy;
use HTTP::Response;
use JSON qw( decode_json ); 
use Log::Log4perl qw(:easy);

our $VERSION = '0.01';

sub new{
  my ($class, $params) = @_;
  my $self = bless {}, $class;

  Log::Log4perl->easy_init($INFO);
  $self->{logger} = Log::Log4perl->get_logger('Net::GereTPs::V1::Session');

  # FIX ME
    $self->{service}{api}{url} = "http://localhost:3000/api";
    $self->{service}{api}{sessions}{url} = "http://localhost:3000/api/sessions";

  $self->{user}{email} = $params->{email};

  if(defined $params->{auth_token}){
    $self->{user}{auth_token} = $params->{auth_token};
  }elsif(defined $params->{password}){
    $self->{user}{password} = $params->{password};
    my $auth_token = $self->request_auth_token($params->{email}, $params->{password});
    $self->{user}{auth_token} = $auth_token;
  }

  return $self;
}

sub get_auth_token{
  my $self = shift;
  return $self->{user}{auth_token};
}

sub get_email{
  my $self = shift;
  return $self->{user}{email};
}

sub request_auth_token{
  my $self = shift;
  my $auth_token;

  my $json_response = $self->create_session();
  $auth_token = $json_response->{'authentication'}->{'user_token'};

  return $auth_token;
}

sub create_session{
  my $self = shift;
  my $email = $self->{user}{email};
  my $password = $self->{user}{password};
  my $json_response;

  my $data = "user[email]=$email&user[password]=$password";

  my $curl = WWW::Curl::Easy->new;
  $curl->setopt(CURLOPT_HEADER,1);
  $curl->setopt(CURLOPT_URL, $self->{service}{api}{sessions}{url});
  $curl->setopt(CURLOPT_POST, 1);
  $curl->setopt(CURLOPT_POSTFIELDS, $data);  

  my $response;
  $curl->setopt(CURLOPT_WRITEDATA, \$response);

  my $retcode = $curl->perform;
  if (0 == $retcode) {
    $response = HTTP::Response->parse($response);
    $json_response = decode_json $response->decoded_content;
  }

  return $json_response;
}

1;
__END__

=head1 NAME

Net::GereTPs::V1::Session - Perl extension for GereTPs Sessions APIv1

=head1 SYNOPSIS

  use Net::GereTPs::V1::Session;

=head1 DESCRIPTION

=head2 EXPORT

=head1 SEE ALSO

=head1 AUTHOR

André Santos, E<lt>andreccdr@gmail.comE<gt>
Ricardo Branco, E<lt>28.ricardobranco@gmail.comE<gt>
Daniel Carvalho, E<lt>dapcarvalho@gmail.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2014 by GereTPs

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.16.2 or,
at your option, any later version of Perl 5 you may have available.

=cut
