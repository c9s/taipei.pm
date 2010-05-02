package Taipei::View;
use common::sense;
use Jifty::View::Declare -base;
use Jifty::View::Declare::Helpers;

private template 'app_header' => sub {
    h1 { _('Taipei.pm')  };
};

private template 'app_footer' => sub {
};

template 'index.html' => page {
    div {
        {  class is 'content' };
        h1 {  _('Welcome') };
    };

    div {
        { id is "twitter_div" };
        h3 { "Taipei.pm Statuses" };
        ul { id is "twitter_update_list" };
        hyperlink(
            label => "Follow Taipei.pm List on Twitter",
            url => "http://twitter.com/osdc_tw/taipei-pm"
        );
    };

outs_raw <<'TWITTER_STATUSES';
<script type="text/javascript" src="http://twitter.com/javascripts/blogger.js"></script>
<script type="text/javascript">
function twitterCallback3(twitters) {
  var statusHTML = [];
  for (var i=0; i<twitters.length; i++){
    var username = twitters[i].user.screen_name;
    var status = twitters[i].text.replace(/((https?|s?ftp|ssh)\:\/\/[^"\s\<\>]*[^.,;'">\:\s\<\>\)\]\!])/g, function(url) {
      return '<a href="'+url+'">'+url+'</a>';
    }).replace(/\B@([_a-z0-9]+)/ig, function(reply) {
      return  reply.charAt(0)+'<a href="http://twitter.com/'+reply.substring(1)+'">'+reply.substring(1)+'</a>';
    });
    statusHTML.push('<li><a href="http://twitter.com/'+username+'">' + username + '</a> <span>'+status+'</span> <a href="http://twitter.com/'+username+'/statuses/'+twitters[i].id+'">'+relative_time(twitters[i].created_at)+'</a></li>');
  }
  document.getElementById('twitter_update_list').innerHTML = statusHTML.join('');
}
</script>
<script type="text/javascript" src="http://api.twitter.com/1/osdc_tw/lists/taipei-pm/statuses.json?callback=twitterCallback3&amp;count=10"></script>
TWITTER_STATUSES

};

1;
