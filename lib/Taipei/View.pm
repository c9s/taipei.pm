package Taipei::View;
use common::sense;
use Jifty::View::Declare -base;
use Jifty::View::Declare::Helpers;

private template 'app_header' => sub {
    div {
        { id is 'site-header'; class is 'row' };

        h1 {
            { id is "site-name"; };
            outs _('Taipei.pm');
        };
    };
};

private template 'app_footer' => sub {
    div {
        { id is "site-footer"; class is 'row' };

        ul {
            li { hyperlink(label => _('Taipei.pm'), url => "http://taipei.pm.org") };
            li { hyperlink(label => _('Chupei.pm'), url => "http://chupei.pm.org") };
        };
    };
};

template 'index.html' => page {
    show 'app_header';

    div {
        { class is 'row' };

        div {
            {  class is 'content column grid_8' };

            div { class is 'lipsum(20)' };
        };

        div {
            { class is 'column grid_4' };

            h3 { "Taipei.pm Statuses" };
            ul { id is "twitter_update_list" };
            hyperlink(label => "Follow Taipei.pm on Twitter", url => "http://twitter.com/osdc_tw/taipei-pm");
        };
    };

    show 'app_footer';

outs_raw <<'TWITTER_STATUSES';
<script type="text/javascript">
function relative_time(time_value) {
  var values = time_value.split(" ");
  time_value = values[1] + " " + values[2] + ", " + values[5] + " " + values[3];
  var parsed_date = Date.parse(time_value);
  var relative_to = (arguments.length > 1) ? arguments[1] : new Date();
  var delta = parseInt((relative_to.getTime() - parsed_date) / 1000);
  delta = delta + (relative_to.getTimezoneOffset() * 60);

  if (delta < 60) {
    return 'less than a minute ago';
  } else if(delta < 120) {
    return 'about a minute ago';
  } else if(delta < (60*60)) {
    return (parseInt(delta / 60)).toString() + ' minutes ago';
  } else if(delta < (120*60)) {
    return 'about an hour ago';
  } else if(delta < (24*60*60)) {
    return 'about ' + (parseInt(delta / 3600)).toString() + ' hours ago';
  } else if(delta < (48*60*60)) {
    return '1 day ago';
  } else {
    return (parseInt(delta / 86400)).toString() + ' days ago';
  }
}

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
<script type="text/javascript" src="http://api.twitter.com/1/osdc_tw/lists/taipei-pm/statuses.json?callback=twitterCallback3"></script>
TWITTER_STATUSES

    outs_raw '<script src="http://more.handlino.com/javascripts/moretext-1.0.js" type="text/javascript"></script>';
};

1;
