# 
# This file is part of Games-Pandemic
# 
# This software is Copyright (c) 2009 by Jerome Quelin.
# 
# This is free software, licensed under:
# 
#   The GNU General Public License, Version 3, June 2007
# 
package Games::Pandemic::Role::OperationsExpert;
our $VERSION = '0.4.0';

# ABSTRACT: operations expert pandemic role

use 5.010;
use strict;
use warnings;

use Moose::Role;
use Games::Pandemic::Utils;


around can_build_anywhere => sub { 1 };
sub color { '#79af00'              }
sub role  { T('Operations Expert') }
sub _role { 'ops-expert'           }


no Moose::Role;
# moose::role cannot be made immutable
#__PACKAGE__->meta->make_immutable;

1;



=pod

=head1 NAME

Games::Pandemic::Role::OperationsExpert - operations expert pandemic role

=head1 VERSION

version 0.4.0

=begin Pod::Coverage

color
role

=end Pod::Coverage

=head1 AUTHOR

  Jerome Quelin

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2009 by Jerome Quelin.

This is free software, licensed under:

  The GNU General Public License, Version 3, June 2007

=cut 



__END__