# 
# This file is part of Games-Pandemic
# 
# This software is Copyright (c) 2009 by Jerome Quelin.
# 
# This is free software, licensed under:
# 
#   The GNU General Public License, Version 2, June 1991
# 
use 5.010;
use strict;
use warnings;

package Games::Pandemic::Role::Dispatcher;
our $VERSION = '1.092640';

# ABSTRACT: dispatcher pandemic role

use Moose::Role;
use Games::Pandemic::Utils;


around can_join_others => sub { 1 };
around can_move_others => sub { 1 };
sub color { '#af4377' }
sub role  { T('Dispatcher') }
sub _role { 'dispatcher' }


no Moose::Role;
# moose::role cannot be made immutable
#__PACKAGE__->meta->make_immutable;

1;



=pod

=head1 NAME

Games::Pandemic::Role::Dispatcher - dispatcher pandemic role

=head1 VERSION

version 1.092640

=begin Pod::Coverage

color
role

=end Pod::Coverage

=head1 AUTHOR

  Jerome Quelin

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2009 by Jerome Quelin.

This is free software, licensed under:

  The GNU General Public License, Version 2, June 1991

=cut 



__END__