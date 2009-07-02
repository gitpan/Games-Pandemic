# 
# This file is part of Games-Pandemic
# 
# This software is Copyright (c) 2009 by Jerome Quelin.
# 
# This is free software, licensed under:
# 
#   The GNU General Public License, Version 3, June 2007
# 
package Games::Pandemic::City;
our $VERSION = '0.4.0';

# ABSTRACT: city object for Games::Pandemic

use 5.010;
use strict;
use warnings;

use Moose;
use MooseX::AttributeHelpers;
use MooseX::SemiAffordanceAccessor;

use Games::Pandemic::Utils;


# -- accessors

# WARNING: do not use y as an attribute name, since it confuses the
# hell out of xgettext when one tries to access $foo->y. indeed, it
# will skip random portions of your file, without any warning.
# therefore, i'm using coordx / coordy.
has id      => ( is => 'ro', required => 1, isa => 'Int' );
has name    => ( is => 'ro', required => 1, isa => 'Str' );
has coordx  => ( is => 'ro', required => 1, isa => 'Num' );
has coordy  => ( is => 'ro', required => 1, isa => 'Num' );
has xreal   => ( is => 'ro', required => 1, isa => 'Num' );
has yreal   => ( is => 'ro', required => 1, isa => 'Num' );
has disease => ( is => 'ro', required => 1, isa => 'Games::Pandemic::Disease', weak_ref => 1 );
has _map    => ( is => 'ro', required => 1, isa => 'Games::Pandemic::Map', weak_ref => 1 );



has has_station => (
    metaclass => 'Bool',
    is        => 'rw',
    isa       => 'Bool',
    default   => 0,
    provides  => {
        set     => 'build_station',
        unset   => 'quash_station',
    }
);

#
# _infections is an array of integer. the indexes are the disease ids,
# and the values are the number of disease items on the city.
#
# private methods provided:
#  . my $nb = $city->_get_infection($id);
#    return the number of item for disease $id in the $city.
#    see public method get_infection()
#
#  . $city->_set_infection($id, $nb);
#    set the new number $nb of items for disease $id in the $city.
#    see public method infect()
#
has _infections => (
    metaclass => 'Collection::Array',
    is        => 'ro',
    isa       => 'ArrayRef[Int]',
    default   => sub { [] },
    provides  => {
        get => '_get_infection',
        set => '_set_infection',
    },
);

has neighbour_ids => (
    metaclass => 'Collection::Array',
    is        => 'ro',
    required  => 1,
    isa       => 'ArrayRef',
    provides  => {
        elements => '_neighbour_ids',
    },
);


# -- default builders / finishers

sub DEMOLISH {
    my $self = shift;
    debug( "~city: " . $self->name . "\n" );
}


# -- public methods


sub neighbours {
    my $self = shift;
    my $map = $self->_map;
    return map { $map->city($_) } $self->_neighbour_ids;
}



sub infect {
    my ($self, $nb, $disease) = @_;
    $nb      //= 1;
    $disease //= $self->disease;

    # perform the infection
    my $id  = $disease->id;
    my $old = $self->_get_infection($id) // 0; # FIXME//padre
    my $new = $old + $nb;
    my $max = $self->_map->max_infections;

    # check for outbreak
    my $outbreak = 0;
    if ( $new > $max ) {
        $new      = $max;
        $outbreak = 1;
    }

    # store new infection state & return outbreak status
    $self->_set_infection( $id, $new );
    return $outbreak;
}



sub get_infection {
    my ($self, $disease) = @_;
    return $self->_get_infection( $disease->id ) // 0; # FIXME//padre
}



sub treat {
    my ($self, $disease, $nb) = @_;
    my $before = $self->get_infection($disease);
    $self->_set_infection( $disease->id, $before-$nb );
}




no Moose;
__PACKAGE__->meta->make_immutable;

1;



=pod

=head1 NAME

Games::Pandemic::City - city object for Games::Pandemic

=head1 VERSION

version 0.4.0

=begin Pod::Coverage

DEMOLISH

=end Pod::Coverage

=head1 DESCRIPTION

This module implements a class for city objects, used in Pandemic. They
have different attributes:

=over 4

=item * name: the city name

=item * xreal: the x coord of the city

=item * yreal: the y coord of the city

=item * coordx: the x coord where city information will be put

=item * coordy: the y coord where city information will be put

=item * disease: a ref to a C<Games::Pandemic::Disease> object, which is
the disease which will infect the city by default

=back 

=head1 METHODS

=head2 $city->build_station;

Create a research station in the city.

=head2 $city->quash_station;

Remove the research station that was in the city.

=head2 my $bool = $city->has_station;

Return true if the city has a research station.



=head2 my @cities = $city->neighbours;

Return a list of C<Games::Pandemic::City>, which are the direct
neighbours of C<$city>.



=head2 my $outbreak = $city->infect( [ $nb [, $disease] ] )

Infect C<$city> with C<$nb> items of C<$disease>. Return true if an
outbreak happened following this infection, false otherwise.

C<$nb> defaults to 1, and C<$disease> to the city disease.



=head2 my $nb = $city->get_infection( $disease );

Return the number of C<$disease> items for the C<$city>.



=head2 $city->treat( $disease, $nb );

Remove C<$nb> items from C<$disease> in C<$city>.



=head1 AUTHOR

  Jerome Quelin

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2009 by Jerome Quelin.

This is free software, licensed under:

  The GNU General Public License, Version 3, June 2007

=cut 



__END__