package CoinMarketCap;

use strict;
use warnings;

use LWP::UserAgent ();
use LWP::Protocol::https;
use JSON;

require Exporter;

our @ISA = qw(Exporter);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use CoinMarketCap ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
our %EXPORT_TAGS = ( 'all' => [ qw(
) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
);

our $VERSION = '0.01';

sub new
{
    my $class = shift;
    
    $class //= 'CoinMarketCap';

    my $self = {};
    bless $self, $class;

    $self->_initialize();
    
    return $self;
}

sub _initialize
{
    my $self = shift;

    $$self{ua} = LWP::UserAgent->new;
    $$self{ua}->agent("CoinMarketCap - Perl Wrapper / $VERSION");
    $$self{ua}->timeout(10);
    $$self{ua}->env_proxy;

    return;
}

sub ticker 
{
    my $self = shift;
    my ($params) = @_;

    my $query = '';

    foreach my $param (('start', 'limit', 'convert'))
    {
        if (defined $$params{$param})
        {
            $query += ((length $query) == 0) ? '?' : '%';
            $query += "$param=$$params{$param}";
        }
    }
   

    # debug
    print STDERR "REQ: https://api.coinmarketcap.com/v1/ticker/$query\n";

    my $response = $$self{ua}->get("https://api.coinmarketcap.com/v1/ticker/$query");
    
    if ($response->is_success)
    {
        return decode_json($response->decoded_content);
    }
    else
    {
        die $response->status_line;
    }
}

sub global 
{
    my $self = shift;
    my ($params) = @_;

    my $query = defined $$params{convert} ? "?convert=$$params{convert}" : '';
    
    # debug
    print STDERR "REQ: https://api.coinmarketcap.com/v1/global/$query\n";
    
    my $response = $$self{ua}->get("https://api.coinmarketcap.com/v1/global/$query");

    if ($response->is_success)
    {
        return decode_json($response->decoded_content);
    }
    else
    {
        die $response->status_line;
    }
}

1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

CoinMarketCap's API wrapped for Perl

=head1 SYNOPSIS

  use CoinMarketCap qw(ticker global);

  # Get ticker data for currency with id: etherium
  my $result = ticker "etherium";

=head1 DESCRIPTION

Stub documentation for CoinMarketCap, created by h2xs. It looks like the
author of the extension was negligent enough to leave the stub
unedited.

Blah blah blah.

=head2 EXPORT

None by default.



=head1 SEE ALSO

Mention other useful documentation such as the documentation of
related modules or operating system documentation (such as man pages
in UNIX), or any relevant external documentation such as RFCs or
standards.

If you have a mailing list set up for your module, mention it here.

If you have a web site set up for your module, mention it here.

=head1 AUTHOR

A. U. Thor, E<lt>thunder@nonetE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2018 by A. U. Thor

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.26.1 or,
at your option, any later version of Perl 5 you may have available.


=cut
