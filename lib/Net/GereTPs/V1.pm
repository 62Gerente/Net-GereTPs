package Net::GereTPs::V1;

use 5.012000;
use strict;
use warnings;
use Log::Log4perl qw(:easy);
use Net::GereTPs::V1::Session;

our $VERSION = '0.01';

sub new{
  my ($class, $params) = @_;
  my $self = bless {}, $class;

  Log::Log4perl->easy_init($INFO);
  $self->{logger} = Log::Log4perl->get_logger('Net::GereTPs::V1');

  # FIX ME
    $self->{service}{api}{url} = "http://localhost:3000/api";
  
  $self->{user}{email} = $params->{email};

  if(defined $params->{auth_token}){
    $self->{user}{auth_token} = $params->{auth_token};
  }elsif(defined $params->{password}){
    my $session = Net::GereTPs::V1::Session->new({email => $params->{email}, password => $params->{password}});
    $self->{user}{auth_token} = $session->get_auth_token();
  }

  return $self;
}

sub session{
  my $self = shift;
  my $auth_token = $self->{user}{auth_token};
  my $email = $self->{user}{email};

  return Net::GereTPs::V1::Session->new({email => $email, auth_token => $auth_token});
}

1;
__END__

=head1 NAME

Net::GereTPs::V1 - Perl extension for GereTPs APIv1

=head1 SYNOPSIS

  use Net::GereTPs::V1;

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
