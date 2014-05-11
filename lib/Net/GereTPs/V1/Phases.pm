package Net::GereTPs::V1::Phases;

use 5.012000;
use strict;
use warnings;
use WWW::Curl::Easy;
use HTTP::Response;
use JSON qw( decode_json ); 

our $VERSION = '0.01';

sub new{
  my ($class, $params) = @_;
  my $self = bless {}, $class;

  $self->{user}{email} = $params->{email};

  if(defined $params->{auth_token}){
    $self->{user}{auth_token} = $params->{auth_token};
  }elsif(defined $params->{password}){
    $self->{user}{password} = $params->{password};
    my $auth_token = $self->request_auth_token($params->{email}, $params->{password});
    $self->{user}{auth_token} = $auth_token;
  }

  if(defined $params->{project}){
    $self->{project} = $params->{project};

    #FIX ME
      $self->{service}{api}{phases}{url} = "http://localhost:3000/api/projects/$self->{project}/phases";
  }else{
    #FIX ME
      $self->{service}{api}{phases}{url} = "http://localhost:3000/api/phases";
  }

  return $self;
}

sub get{
  my ($self, $id) = @_;
  my $email = $self->{user}{email};
  my $auth_token = $self->{user}{auth_token};

  my $data = "user_email=$email&user_token=$auth_token";

  return decode_json _curl("GET", "$self->{service}{api}{phases}{url}/$id", $data);
}

sub get_xml{
  my ($self, $id) = @_;
  my $email = $self->{user}{email};
  my $auth_token = $self->{user}{auth_token};

  my $data = "user_email=$email&user_token=$auth_token";

  return _curl("GET", "$self->{service}{api}{phases}{url}/$id.xml", $data);
}

sub all{
  my $self = shift;
  my $email = $self->{user}{email};
  my $auth_token = $self->{user}{auth_token};

  my $data = "user_email=$email&user_token=$auth_token";

  return decode_json _curl("GET", $self->{service}{api}{phases}{url}, $data);
}

sub _curl{
  my ($method, $url, $data) = @_;

  my $curl = WWW::Curl::Easy->new;
  $curl->setopt(CURLOPT_HEADER,1);
  $curl->setopt(CURLOPT_URL, $url);
  $curl->setopt(CURLOPT_CUSTOMREQUEST, $method);  
  $curl->setopt(CURLOPT_POSTFIELDS, $data);  

  my $response;
  $curl->setopt(CURLOPT_WRITEDATA, \$response);

  my $retcode = $curl->perform;
  if (0 == $retcode) {
    $response = HTTP::Response->parse($response);
  }

  return $response->decoded_content;
}

1;
__END__

=head1 NAME

Net::GereTPs::V1::Phases - Perl extension for GereTPs Phases APIv1

=head1 SYNOPSIS

  use Net::GereTPs::V1::Phases;

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
