# 
# This file is part of Games-Pandemic
# 
# This software is Copyright (c) 2009 by Jerome Quelin.
# 
# This is free software, licensed under:
# 
#   The GNU General Public License, Version 3, June 2007
# 
use 5.010;
use strict;
use warnings;

package Games::Pandemic::Card::City;
our $VERSION = '0.8.0';

# ABSTRACT: pandemic city card

use Moose;
use MooseX::SemiAffordanceAccessor;

extends 'Games::Pandemic::Card';

# -- accessors

has city => (
    is => 'ro',
    isa => 'Games::Pandemic::City',
    weak_ref => 1,
);


# -- default builders

sub _build_icon {
    my $self = shift;
    return $self->city->disease->image('cube',16);
}

sub _build_label {
    my $self = shift;
    return $self->city->name;
}


no Moose;
__PACKAGE__->meta->make_immutable;

1;



=pod

=head1 NAME

Games::Pandemic::Card::City - pandemic city card

=head1 VERSION

version 0.8.0

=head1 AUTHOR

  Jerome Quelin

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2009 by Jerome Quelin.

This is free software, licensed under:

  The GNU General Public License, Version 3, June 2007

=cut 



__END__