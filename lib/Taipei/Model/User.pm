use strict;
use warnings;

package Taipei::Model::User;
use Jifty::DBI::Schema;

use Taipei::Record schema {

column
  role => type is 'varchar',
  valid are qw(user staff admin),
  default is 'user',
  is immutable;

};

use Jifty::Plugin::User::Mixin::Model::User;
use Jifty::Plugin::Authentication::Password::Mixin::Model::User qw(password_is hashed_password_is regenerate_auth_token);
use Jifty::Plugin::OpenID::Mixin::Model::User qw();

sub brief_description {
    my $self = shift;
    return _("%1 %2", _($self->salut), $self->last_name);
}

sub current_user_can {
    my $self  = shift;
    my $right = shift;
    my %args  = (@_);

    # This line breaks admin mode. I like admin mode.
    #    Carp::confess if ( $right eq 'read' and not $args{'column'} );
    if ( $right eq 'read' and not defined $args{'column'} ) {
        # Someone wants to know if they can read any part of the record, tell
        # them they can.  If they try to read a column they aren't allowed to,
        # they'll get refused later.
        return (1);
    } elsif ( $right eq 'read' and defined $args{'column'} and $args{'column'} =~ /^(?:name|bio)$/ ) {
        return (1);
    } elsif ( $self->current_user->id ) {
        if (    $right eq 'read'
            and $self->id == $self->current_user->id )
        {
            return 1;
        } elsif ( $right eq 'update'
            and $self->id == $self->current_user->id
            and $args{'column'} ne 'email_confirmed' )
        {
            return (1);
        }
    }
    return $self->SUPER::current_user_can( $right, %args );
}

1;

