package Perl::Achievements::Report::Html;
BEGIN {
  $Perl::Achievements::Report::Html::AUTHORITY = 'cpan:YANICK';
}
{
  $Perl::Achievements::Report::Html::VERSION = '0.4.0';
}

use 5.10.0;

use strict;
use warnings;

use Moose;

use Method::Signatures;
use Template::Caribou::Utils;
use Template::Caribou::Tags::HTML;

with qw/ Template::Caribou Perl::Achievements::Role::Report /;

method generate {
    return $self->render( 'page' );
};

template page => sub {
    my $self = shift;

    my %latest;

    for( @{ $self->history } ) {
        $latest{$_->{achievement}} = $_;
    }

    html {
        show( 'head' );
        body {
            show( 'pa_signature' );

            h1 {
                say $self->who, "'s " if $self->who;
                say "Perl Achievements";
            };

            for ( values %latest ) {
                div {
                    attr class => 'achievement';
                    div {
                        attr class => 'short_title header';
                        $_->{achievement}
                    };
                    div {
                        attr class => 'level header';
                        $_->{level}
                    } if $_->{level};
                    div {
                        attr class => 'details';
                        $_->{details}
                    } if $_->{details};
                }
            }
        };
    }
};

#http://colorschemedesigner.com/#3O12.8tPkNQDa
#ACB9E1
#747987
#102564;
#CDD6F4
#DBE1F4;
template head => sub {
    head {
        style {
            <<'EOT';
body {
    font-family: Arial, 'sans';
    width: 800px;
    margin: 0 auto;
    background: #102564;
    color: white;
}

h1 {
    text-align: center;
}

.pa_signature {
    position: absolute;
    right: 5px;
    top: 5px;
}

a:visited { color: white; }

.achievement {
    margin-bottom: 10px;
}

.achievement div.header {
    font-size: 16pt;
    border-radius: 10px 10px 0px 0px;
    border-color: #747987;
    padding: 4px 10px;
    display: inline-block;
    background: #747987;
}

div.level { 
    float: right;
}
div.level:before { content: "level " }

div.details {
    background-color: #747987;
    border-color: 1px #747987 solid;
    border-radius: 0px 0px 10px 10px;
    padding: 10px;
    font-style: italic;
}
EOT
        }
    };
};

template 'pa_signature' => sub {
    div {
        attr class => 'pa_signature';
        say ::RAW <<'END';
generated by <a href='https://metacpan.org/release/Perl-Achievements'
>Perl::Achievements</a>
END
    }
};

1;

__END__
=pod

=head1 NAME

Perl::Achievements::Report::Html

=head1 VERSION

version 0.4.0

=head1 AUTHOR

Yanick Champoux <yanick@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Yanick Champoux.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

