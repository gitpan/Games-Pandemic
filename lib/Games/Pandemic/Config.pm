# 
# This file is part of Games-Pandemic
# 
# This software is Copyright (c) 2009 by Jerome Quelin.
# 
# This is free software, licensed under:
# 
#   The GNU General Public License, Version 3, June 2007
# 
package Games::Pandemic::Config;
our $VERSION = '0.4.0';

# ABSTRACT: local configuration for Games::Pandemic

use 5.010;
use strict;
use warnings;

use Games::Pandemic::Utils;
use MooseX::Singleton;          # should come before any other moose
use MooseX::AttributeHelpers;
use MooseX::SemiAffordanceAccessor;
use YAML::Tiny qw{ LoadFile };

my $default = {
    canvas_height => 600,
    canvas_width  => 1024,
};

# -- accessors

has '_options' => (
    metaclass => 'Collection::Hash',
    is        => 'ro',
    isa       => 'HashRef[Str]',
    builder   => '_build_options',
    provides  => {
        'set'    => 'set',
        'get'    => '_get',
        'exists' => '_exists',
    }
);

# -- public methods


sub get {
    my ($self, $key) = @_;
    my $val = $self->_get($key) // $default->{$key}; # /FIXME padre highlight
}

# -- private subs

sub _build_options {
    my $yaml = eval { LoadFile( "$CONFIGDIR/config.yaml" ) };
    return $@ ? {} : $yaml;
}


no Moose;
# singleton classes cannot be made immutable
#__PACKAGE__->meta->make_immutable;

1;



=pod

=head1 NAME

Games::Pandemic::Config - local configuration for Games::Pandemic

=head1 VERSION

version 0.4.0

=head1 SYNOPSIS

    use Games::Pandemic::Config;
    my $config = Games::Pandemic::Config->instance;
    my $width  = $config->get( 'canvas_width' );

=head1 DESCRIPTION

This module implements a basic persistant configuration, using key /
value pairs.

The module itself is implemented as a singleton, available with the
C<instance()> class method.

=head1 METHODS

=head2 my $value = $config->get( $key )

Return the C<$value> associated to C<$key> in the configuration.
Note that if there's no local configuration defined, a default will
be provided.



=head1 AUTHOR

  Jerome Quelin

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2009 by Jerome Quelin.

This is free software, licensed under:

  The GNU General Public License, Version 3, June 2007

=cut 



__END__