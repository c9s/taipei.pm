package Taipei::View;
use warnings;
use strict;
use Jifty::View::Declare -base;
use Jifty::View::Declare::Helpers;

template 'app_header' => sub {

    h1 { _('Taipei.pm')  };

};

template 'app_footer' => sub {

};

template 'index.html' => page {

    div {  {  class is 'content' };
    
    
    };

};

1;
