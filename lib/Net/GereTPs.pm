package Net::GereTPs;

use 5.012000;
use strict;
use warnings;
use Net::GereTPs::V1;
use Log::Log4perl qw(:easy);

our $VERSION = '0.01';

sub new{
  my ($class, $params) = @_;

  Log::Log4perl->easy_init($INFO);
  my $logger = Log::Log4perl->get_logger('Net::GereTPs');

  if(defined $params->{version} && $params->{version} != 1){
    $logger->error("Invalid version.");
    exit(1);
  }

  return Net::GereTPs::V1->new($params);
}

1;
__END__

=head1 NAME

Net::GereTPs - Perl extension for GereTPs API

=head1 SYNOPSIS

  use Net::GereTPs;

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
