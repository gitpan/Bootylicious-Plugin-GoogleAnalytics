package Bootylicious::Plugin::GoogleAnalytics;

use strict;
use warnings;

use base 'Mojo::Base';

use Mojo::ByteStream 'b';

our $VERSION = '0.990201';

sub register {
    my ($self, $app, $args) = @_;

    $args ||= {};

    return unless $args->{urchin};

    $app->plugins->add_hook(
        after_dispatch => sub {
            my ($self, $c) = @_;

            my $body = $c->res->body;

            $c->stash(urchin => $args->{urchin});

            my $ga_script = $c->render_partial(
                'template',
                format         => 'html',
                template_class => __PACKAGE__,
                handler        => 'ep'
            );

            $ga_script = b($ga_script)->encode('utf-8');

            $body =~ s{</body>}{$ga_script</body>};
            $c->res->body($body);
        }
    );
}

1;
__DATA__

@@ template.html.ep
<script type="text/javascript">
var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
</script>
<script type="text/javascript">
try {
var pageTracker = _gat._getTracker("<%= $urchin %>");
pageTracker._trackPageview();
} catch(err) {}</script>

__END__

=head1 NAME

Bootylicious::Plugin::GoogleAnalytics - google analytics plugin for bootylicious

=head1 SYNOPSIS

    # In your bootylicious.conf

    "plugins" : [
        "google_analytics", {"urchin" : "UA-12345-1}
    ]

=head1 DESCRIPTION

Plugins adds Google Analytics script to your L<bootylicious> blog.

=head1 ATTRIBUTES

=head2 C<urchin>

    Your urchin.

=head1 METHODS

=head2 C<hook_finalize>

    Plugin is run just after L<bootylicious> template rendering.

=head1 SEE ALSO

    L<bootylicious>, L<Mojo>, L<Mojolicious>

=head1 AUTHOR

Viacheslav Tykhanovskyi, C<vti@cpan.org>.

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2009, Viacheslav Tykhanovskyi.

This program is free software, you can redistribute it and/or modify it under
the terms of the Artistic License version 2.0.

=cut
