package Taipei::View::Page;
use warnings;
use strict;

use strict;
use warnings;
use base qw/Jifty::View::Declare::Page/;
use Class::Trigger;
use Jifty::View::Declare::Helpers;

__PACKAGE__->mk_accessors(qw(_meta));

sub render_body {
    my ($self, $body_code) = @_;
    $self->render_header();
    body { 
        $self->render_pre_content_hook();
        $body_code->();
    };
}

use utf8;

sub render_page {
  my $self = shift;

  div { { class is 'container' };
        # div { { id is 'hd' };
        set(title => $self->_title);


        #};

    div { { id is 'bd' };
      Carp::cluck $self unless $self->content_code;
      $self->content_code->();
    };
  };

}

sub render_footer {
    my $self = shift;
    $self->SUPER::render_footer;
}

1;
