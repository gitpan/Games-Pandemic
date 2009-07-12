# 
# This file is part of Games-Pandemic
# 
# This software is Copyright (c) 2009 by Jerome Quelin.
# 
# This is free software, licensed under:
# 
#   The GNU General Public License, Version 3, June 2007
# 
package Games::Pandemic::Tk::Dialog::DropCards;
our $VERSION = '0.5.0';

# ABSTRACT: dropping cards dialog window for Games::Pandemic

use 5.010;
use strict;
use warnings;

use Moose;
use MooseX::SemiAffordanceAccessor;
use POE;
use Readonly;
use Tk;

extends 'Games::Pandemic::Tk::Dialog';

use Games::Pandemic::Utils;
use Games::Pandemic::Tk::Utils;

Readonly my $K => $poe_kernel;


# -- accessors

# player that will loose some cards
has player => ( is=>'ro', required=>1, weak_ref=>1, isa=>'Games::Pandemic::Player' );

# selected cards to be dropped
has _cards => (
    metaclass  => 'Collection::Hash',
    is         => 'ro',
    isa        => 'HashRef[Games::Pandemic::Card]',
    default    => sub { {} },
    provides   => {
        values  => '_selcards',
        delete  => '_deselect_card',
        set     => '_select_card',
        exists  => '_is_card_selected',
    }
);


# -- initialization

#
# BUILD()
#
# called as constructor initialization
#
sub BUILD {
    my $self = shift;
    $self->_w('ok')->configure(@ENOFF);
}

sub _build_title   { T('Discard') }
sub _build_header  { T('Drop some cards') }
sub _build__ok     { T('Drop') }
sub _build__cancel { T('Cancel') }


# -- gui methods

#
# $dialog->_card_click($card);
#
# user has de/selected a card.
#
sub _card_click {
    my ($self, $card) = @_;

    # toggle card state
    if ( $self->_is_card_selected($card) ) {
        $self->_deselect_card($card);
    } else {
        $self->_select_card($card, $card);
    }

    # 
    my @cards = $self->_selcards;
    $self->_w('ok')->configure( scalar(@cards) ? @ENON : @ENOFF );
}

#
# $dialog->_valid;
#
# request to drop card(s) & destroy the dialog.
#
sub _valid {
    my $self = shift;
    $K->post( controller => 'drop_cards', $self->player, $self->_selcards );
    $self->_close;
}


# -- private methods

#
# $main->_build_gui;
#
# create the various gui elements.
#
augment _build_gui => sub {
    my $self = shift;
    my $top  = $self->_toplevel;

    my $player = $self->player;
    my @cards  = sort { $a->label cmp $b->label } $player->all_cards;

    my $f = $top->Frame->pack(@TOP, @XFILL2, @PAD10);
    $f->Label(
        -text   => T('Select cards to drop:'),
        -anchor => 'w',
    )->pack(@TOP, @FILLX);

    # display cards
    foreach my $card ( @cards ) {
        # to display a checkbutton with image + text, we need to
        # create a checkbutton with a label just next to it.
        my $fcity = $f->Frame->pack(@TOP, @FILLX);
        my $selected;
        my $cb = $fcity->Checkbutton(
            -image    => image($card->icon, $top),
            -command  => sub { $self->_card_click($card); },
        )->pack(@LEFT);
        my $lab = $fcity->Label(
            -text   => $card->label,
            -anchor => 'w',
        )->pack(@LEFT, @FILLX);
        $lab->bind( '<1>', sub { $cb->invoke; } );
    }
};



no Moose;
__PACKAGE__->meta->make_immutable;

1;



=pod

=head1 NAME

Games::Pandemic::Tk::Dialog::DropCards - dropping cards dialog window for Games::Pandemic

=head1 VERSION

version 0.5.0

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