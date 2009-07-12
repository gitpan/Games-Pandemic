# 
# This file is part of Games-Pandemic
# 
# This software is Copyright (c) 2009 by Jerome Quelin.
# 
# This is free software, licensed under:
# 
#   The GNU General Public License, Version 3, June 2007
# 
package Games::Pandemic::Card;
our $VERSION = '0.5.0';

# ABSTRACT: base class for pandemic cards

use 5.010;
use strict;
use warnings;

use Moose;
use MooseX::SemiAffordanceAccessor;

# -- accessors

has label => ( is => 'ro', isa => 'Str', lazy_build => 1 );
has icon  => ( is => 'ro', isa => 'Str', lazy_build => 1 );

no Moose;
__PACKAGE__->meta->make_immutable;

1;



=pod

=head1 NAME

Games::Pandemic::Card - base class for pandemic cards

=head1 VERSION

version 0.5.0

=head1 AUTHOR

  Jerome Quelin

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2009 by Jerome Quelin.

This is free software, licensed under:

  The GNU General Public License, Version 3, June 2007

=cut 



__END__