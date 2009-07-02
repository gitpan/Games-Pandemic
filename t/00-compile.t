#!perl
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

use File::Find::Rule;
use Test::More;
use Test::Script;

my @files = File::Find::Rule->relative->file->name('*.pm')->in('lib');
plan tests => scalar(@files) + 1;

foreach my $file ( @files ) {
    my $module = $file;
    $module =~ s/[\/\\]/::/g;
    $module =~ s/\.pm$//;
    is( qx{ $^X -M$module -e "print '$module ok'" }, "$module ok", "$module loaded ok" );
}

script_compiles_ok( 'bin/pandemic', 'main script compiles' );