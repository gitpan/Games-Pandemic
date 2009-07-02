# 
# This file is part of Games-Pandemic
# 
# This software is Copyright (c) 2009 by Jerome Quelin.
# 
# This is free software, licensed under:
# 
#   The GNU General Public License, Version 3, June 2007
# 
package Games::Pandemic::Disease;
our $VERSION = '0.4.0';

# ABSTRACT: disease object for Games::Pandemic

use 5.010;
use strict;
use warnings;

use File::Spec::Functions qw{ catfile };
use Moose;
use MooseX::AttributeHelpers;
use MooseX::SemiAffordanceAccessor;

use Games::Pandemic::Utils;


# -- attributes

has 'colors' => (
    metaclass  => 'Collection::List',
    is         => 'ro',
    isa        => 'ArrayRef[Str]',
    required   => 1,
    provides   => { get => 'color' },
);
has id    => ( is => 'ro', isa => 'Int', required   => 1 );
has name  => ( is => 'ro', isa => 'Str', required   => 1 );
has nbleft => (
    metaclass  => 'Number',
    is         => 'ro',
    isa        => 'Int',
    lazy       => 1,
    builder    => '_build_nb',
    provides   => {
        add => 'return',
        sub => 'take',
    },
);
has nbmax => ( is => 'ro', isa => 'Int', required   => 1 );
has _map  => ( is => 'ro', isa => 'Games::Pandemic::Map',required => 1, weak_ref => 1 );

has is_cured => (
    metaclass => 'Bool',
    is        => 'ro',
    isa       => 'Bool',
    default   => 0,
    provides  => {
        set     => 'cure',
    }
);


# -- default builders / finishers

sub DEMOLISH {
    my $self = shift;
    debug( "~disease: " . $self->name . "\n" );
}

sub _build_nb { $_[0]->nbmax }


# -- public methods


sub image {
    my ($self, $what, $size) = @_;
    return catfile( $self->_map->sharedir, $what . '-' . $self->id . "-$size.png" );
}


no Moose;
__PACKAGE__->meta->make_immutable;

1;



=pod

=head1 NAME

Games::Pandemic::Disease - disease object for Games::Pandemic

=head1 VERSION

version 0.4.0

=begin Pod::Coverage

DEMOLISH

=end Pod::Coverage

=head1 METHODS

=head2 my $path = $disease->image($what);

Return the C<$path> to an image for the disease. C<$what> can be either
C<cube> or C<cure>.



=head1 AUTHOR

  Jerome Quelin

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2009 by Jerome Quelin.

This is free software, licensed under:

  The GNU General Public License, Version 3, June 2007

=cut 



__END__