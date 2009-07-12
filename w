#!/usr/bin/perl
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
use Tk;
use Tk::ToolBar;

my $mw = MainWindow->new;
my $tb = $mw->ToolBar(-movable=>0, -side=>'top');
$tb->ToolButton(-text=>'Button',-command => sub { $tb->destroy });
my $tbin = $mw->ToolBar(-movable=>0, -in=>$tb);
$tbin->ToolButton(-text=>'close',-command => sub { $tbin->destroy });
MainLoop;