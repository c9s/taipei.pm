use strict;
use warnings;

package Taipei::Model::Post;
use Jifty::DBI::Schema;

use Taipei::Record schema {

column title => 
    type is 'varchar(255)';

column content =>
    type is 'text';


};

use Jifty::Plugin::ActorMetadata::Mixin::Model::ActorMetadata; # created_by, created_on, updated_on

# Your model-specific methods go here.

1;

