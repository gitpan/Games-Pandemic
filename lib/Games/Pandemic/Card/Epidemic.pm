# 
# This file is part of Games-Pandemic
# 
# This software is Copyright (c) 2009 by Jerome Quelin.
# 
# This is free software, licensed under:
# 
#   The GNU General Public License, Version 3, June 2007
# 
package Games::Pandemic::Card::Epidemic;
our $VERSION = '0.6.0';

# ABSTRACT: epidemic card for pandemic

use 5.010;
use strict;
use warnings;

use Moose;
use MooseX::SemiAffordanceAccessor;

use Games::Pandemic::Utils;

extends 'Games::Pandemic::Card';

# -- default builders

sub _build_icon  { '' }
sub _build_label { T('epidemic') }


no Moose;
__PACKAGE__->meta->make_immutable;

1;



=pod

=head1 NAME

Games::Pandemic::Card::Epidemic - epidemic card for pandemic

=head1 VERSION

version 0.6.0

=head1 DESCRIPTION

This package implements a simple epidemic card, not meant to be
displayed at all.

=head1 AUTHOR

  Jerome Quelin

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2009 by Jerome Quelin.

This is free software, licensed under:

  The GNU General Public License, Version 3, June 2007

=cut 



__END__