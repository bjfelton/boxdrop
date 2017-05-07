#!/usr/bin/perl

use strict;
use warnings;

use File::Basename;

###
# TO-DO: Add a growing status bar for each country -- possibly a dynamically
#        resorting list
##

my @COUNTRIES      = qw/
    India
    Greece
    US-West
    US-EastCoast
    US-Southwest
    US-SoulFood
    RepublicOfTexas
    Acadia
    Jamaica
    Mexico
    Cuba
    WestIndies
    CentralAmerica
    Brazil
    Peru
    Argentina
    UK
    Germany
    France
    Spain-Portugal
    Spain-Tapas
    Basque
    Italy
    Poland
    BalticEurope
    Turkey
    Belgium
    Morocco
    NorthAfrica
    MiddleEast
    Pakistan
    Afghanistan
    China-Dimsum
    China-NotDimsum
    Japan
    Sushi
    Koreas
    Mongolia
    Russia
    Thailand
    Vietnam
    Indonesia
    Malaysia
    Philipines
    Australia
    Ethiopia
    SouthAfrica
    Scandanavia
    Kosher-ish
    GourmetSTL
    Hawaii
    Breakfast
    SteakHouse
/;

my @PREV_COUNTRIES = qw/
    India
    Cuba
    Greece
    Acadia
    Jamaica
    Peru
    Scandanavia
    UK
    Vietnam
    WestIndies
    Afghanistan
    US-West
    US-EastCoast
    US-SoulFood
    Argentina
    Brazil
    Morocco
    Basque
    BalticEurope
    MiddleEast
    RepublicOfTexas
    Mexico
    CentralAmerica
    US-Southwest
    Japan
    Philipines
    Spain-Tapas
    Russia
    Koreas
    France
    Hawaii
    Sushi
    Belgium
    SouthAfrica
/;

$| = 1;

sub usage
{
    my $name = basename $0;

    print <<"USAGE";

    USAGE: $name <threshold>

    <threshold> is the number of times a country must match before it is chosen

USAGE

    exit 2;
}

sub validate
{
    my $country = shift;

    if( $country eq 'Scandanavia' )
    {
        print "\n\nNo one wants Scandanativa.  No.  Just, no.\n";
        print "No one wants to eat a bunch of nasty-ass fermented fish.\n";
        print "No.\n\n";
        print "Continuing...";
        return 0;
    }
    elsif( not grep {/$country/} @PREV_COUNTRIES )
    {
        print "\n\nYour new country is...\n";
        sleep 3;
        print "<drumroll>\n";
        sleep 9;
        print "\n\n *** $country!!! ***\n\n";
        return 1;
    }
    else
    {
        print "\n\nWe've already done $country.\n\n";
        print "Continuing...";
        return 0;
    }
}


sub main
{
    my $threshold = $ARGV[0];

    usage() if not defined $threshold;

    my %store = ();

    my $iterations = 0;

    print "Country Cuisine Choosing in progress...";

    while( 1 )
    {
        $iterations++;
        print "." if( $iterations % 10000 == 0 );

        my $country = $COUNTRIES[ (int(rand 10000) % ($#COUNTRIES)) ];

        $store{$country}++;

        if( $store{$country} > $threshold )
        {
            last if validate( $country );
            $store{$country} = 0;
        }
    }

    sleep 1;
    print "\n\nFinal Vote Counts\n=================\n";
    sleep 2;
    print "$_ = $store{$_}\n"
        for (sort {$store{$b} <=> $store{$a}} keys %store);

    return 0;
}

main();

