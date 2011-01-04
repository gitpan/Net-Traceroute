use strict;
use warnings;

# Library routines used in multiple tests.

use Test::More;
use Net::Traceroute;

# parsetext(text) - return a Net::Traceroute object with the given
# text already parsed.
sub parsetext {
    my $text = shift;
    my $tr = Net::Traceroute->new();
    $tr->text($text);
    $tr->parse();
    return($tr);
}

# parsefh(filehandle) - slurp all text in from filehandle, and offer
# it to parsetext above.  Returns a Net::Traceroute object with the
# text parsed.
sub parsefh {
    my $fh = shift;
    my $text;
    { local $/ = undef; $text = <$fh>; }
    close($fh);
    parsetext($text);
}

1;
