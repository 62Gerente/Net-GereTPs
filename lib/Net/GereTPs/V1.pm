package Net::GereTPs::V1;

use 5.012000;
use strict;
use warnings;
use Log::Log4perl qw(:easy);
use Net::GereTPs::V1::Session;
use Net::GereTPs::V1::Projects;
use Net::GereTPs::V1::Phases;
use Net::GereTPs::V1::Groups;
use Net::GereTPs::V1::Deliveries;
use Net::GereTPs::V1::Documents;
use Data::Dumper;

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

sub projects{
  my $self = shift;
  my $auth_token = $self->{user}{auth_token};
  my $email = $self->{user}{email};

  return Net::GereTPs::V1::Projects->new({email => $email, auth_token => $auth_token});
}

sub phases{
  my ($self, $project) = @_;
  my $auth_token = $self->{user}{auth_token};
  my $email = $self->{user}{email};

  return Net::GereTPs::V1::Phases->new({email => $email, auth_token => $auth_token, project => $project});
}

sub groups{
  my ($self, $entity, $entity_id) = @_;
  my $auth_token = $self->{user}{auth_token};
  my $email = $self->{user}{email};

  return Net::GereTPs::V1::Groups->new({email => $email, auth_token => $auth_token, entity => $entity, entity_id => $entity_id});
}

sub deliveries{
  my ($self, $entity1, $entity1_id, $entity2, $entity2_id) = @_;
  my $auth_token = $self->{user}{auth_token};
  my $email = $self->{user}{email};

  return Net::GereTPs::V1::Deliveries->new({email => $email, auth_token => $auth_token, entity1 => $entity1, entity1_id => $entity1_id, entity2 => $entity2, entity2_id => $entity2_id});
}

sub documents{
  my ($self, $delivery) = @_;
  my $auth_token = $self->{user}{auth_token};
  my $email = $self->{user}{email};

  return Net::GereTPs::V1::Documents->new({email => $email, auth_token => $auth_token, delivery => $delivery});
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
