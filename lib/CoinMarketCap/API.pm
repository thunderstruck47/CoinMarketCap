package CoinMarketCap::API;

use strict;
use warnings;

use Carp;
use Try::Tiny;

use LWP::UserAgent ();
use LWP::Protocol::https;
use JSON;

require Exporter;

our @ISA = qw(Exporter);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration   use CoinMarketCap::API ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
our %EXPORT_TAGS = ( 'all' => [ qw(
) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
);

our $VERSION = '1.0.0a';

sub new
{
    my $class = shift;
    my $api_version = shift // '1'; # TODO: Use hash paramenters instead
    
    my $self = bless {}, $class;
    if ($api_version eq '1')
    {
        $$self{api_url} = 'https://api.coinmarketcap.com/v1/';
    }
    #elsif ($api_version eq '2')
    #{
    #    $$self{api_url} = 'https://api.coinmarketcap.com/v2/';
    #}
    #else
    #{
    #    croak ("Unknown API version '$api_version'! Supported versions: '1'.");
    #}

    $$self{debug} = 1;

    $self->_initialize();
    
    return $self;
}

sub _initialize
{
    my $self = shift;

    $$self{ua} = LWP::UserAgent->new;
    $$self{ua}->agent("CoinMarketCap::API - Perl Wrapper / $VERSION");
    $$self{ua}->timeout(10);
    $$self{ua}->env_proxy;

    return;
}

sub ticker
{
    my $self = shift;
    my $id = ((scalar @_ % 2 == 0) && (ref $_[0] eq '')) ? undef : shift @_;
    my (%params) = @_;

    my $method = (defined $id) ? "ticker/$id" : 'ticker';

    return $self->_get($method, %params);
}

sub global
{
    my ($self, %params) = @_;

    return $self->_get('global', %params);
}

sub _get
{
    my ($self, $method, %params) = @_;

    # TODO: check self or user agent
    unless (ref $method eq '') { $self->_trace("ERR: Expecting method as a string!") };
    unless (ref \%params eq 'HASH') { $self->_trace("ERR: Expecting parameters as key value pairs!") };

    my $query = keys %params ? ('?' . join('%', (map { "$_=$params{$_}" } keys %params))) : '';
    my $request_url = $$self{api_url} . $method . $query;
    $self->_trace("REQ: $request_url");
    
    my $response = $$self{ua}->get($request_url);
    if ($response->is_success)
    {
        return from_json($response->decoded_content);
    }
    else
    {
        try
        {
            return from_json($response->decoded_content);
        }
        catch
        {
            croak $response->status_line;
        }   
    }
}

sub _trace
{
    my $self = shift;
    return if !$$self{debug};

    foreach (@_)
    {
        if (ref $_)
        {
            print STDERR to_json($_);
        }
        else
        {
            print STDERR $_;
        }
        print STDERR ($_ eq $_[-1]) ? "\n" : ' ';
    }

    return;
}

1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

CoinMarketCap's API wrapped for Perl

=head1 SYNOPSIS

  use CoinMarketCap::API;

  my $api = new CoinMarketCap::API;

  my $ticker_data = $api->ticker;
  my $global_data = $api->global;

  my $ethereum_data = $api->ticker('etherium', convert => 'EUR'); 
  my $ticker_data_top_10 = $api->global(limit => '10');

=head1 DESCRIPTION

Stub documentation for CoinMarketCap::API, created by h2xs. It looks like the
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
