# 
# This file is part of Games-Pandemic
# 
# This software is Copyright (c) 2009 by Jerome Quelin.
# 
# This is free software, licensed under:
# 
#   The GNU General Public License, Version 3, June 2007
# 
package Games::Pandemic::Tk::Dialog::Simple;
our $VERSION = '0.6.0';

# ABSTRACT: generic dialog window for Games::Pandemic

use 5.010;
use strict;
use warnings;

use Moose;
use MooseX::SemiAffordanceAccessor;
use Tk;

extends 'Games::Pandemic::Tk::Dialog';

use Games::Pandemic::Utils;
use Games::Pandemic::Tk::Utils;


# -- accessors

has text   => ( is=>'ro', isa=>'Str', required=>1 );
has icon   => ( is=>'ro', isa=>'Str' );


# -- initialization

sub _build__cancel { T('Close') }


# -- private methods

#
# dialog->_build_gui;
#
# create the various gui elements.
#
augment _build_gui => sub {
    my $self = shift;
    my $top  = $self->_toplevel;

    # icon + text
    my $f = $top->Frame->pack(@TOP,@XFILL2);
    $f->Label(-image => image($self->icon,$top))->pack(@LEFT, @FILL2, @PAD10)
        if defined $self->icon;
    $f->Label(
        -text       => $self->text,
        -justify    => 'left',
        -wraplength => '6c',
    )->pack(@LEFT, @XFILL2, @PAD10);
};



no Moose;
__PACKAGE__->meta->make_immutable;

1;



=pod

=head1 NAME

Games::Pandemic::Tk::Dialog::Simple - generic dialog window for Games::Pandemic

=head1 VERSION

version 0.6.0

=begin Pod::Coverage

BUILD

=end Pod::Coverage

=head1 AUTHOR

  Jerome Quelin

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2009 by Jerome Quelin.

This is free software, licensed under:

  The GNU General Public License, Version 3, June 2007

=cut 



__END__