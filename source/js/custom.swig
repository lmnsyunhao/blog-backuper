{### LeanCloud Setting ###}
<script src="//cdn.jsdelivr.net/npm/leancloud-storage@3.11.1/dist/av-min.js"></script>
<script>
  AV.init({
    appId: "{{ theme.leancloud_visitors.app_id }}",
    appKey: "{{ theme.leancloud_visitors.app_key }}"
  });
  var loadcomponent = function(componentname, callback){
    query = new AV.Query('Key');
    query.equalTo("AppName", componentname);
    query.find().then(function (results) {
      callback(results[0].attributes);
    }, function (error) {
    });
  }
</script>

{### DaoVoice Setting ###}
{% if config.daovoice %}
  <script>
    var loaddaovoice = function(data){
      (function(i,s,o,g,r,a,m){i["DaoVoiceObject"]=r;i[r]=i[r]||function(){(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;a.charset="utf-8";m.parentNode.insertBefore(a,m)})(window,document,"script",('https:' == document.location.protocol ? 'https:' : 'http:') + "//widget.daovoice.io/widget/"+data.AppKey+".js","daovoice")
      daovoice('init', {
          app_id: data.AppKey
        });
      daovoice('update');
    }
  </script>
{% endif %}

{### Gitalk Setting ###}
{% if page.comments and config.gitalk.enable %}
  <link rel="stylesheet" href="{{ theme.vendors.gitalk_css }}">
  <script src="{{ theme.vendors.gitalk_js }}"></script>
  <script src="{{ theme.vendors.md5 }}"></script>
  <script>
    var loadgitalk = function(data){
      gitalk = new Gitalk({
        clientID: data.AppID,
        clientSecret: data.AppKey,
        repo: '{{ config.gitalk.repo }}',
        owner: '{{ config.gitalk.owner }}',
        admin: '{{ config.gitalk.admin }}',
        id: md5(location.pathname),
        distractionFreeMode: 'true'
      });
      {% if page.type == "comments" %}
        $('#posts>.post-block:first').append("<div id='comments'></div>");
        gitalk.render('comments');
        $('#posts>.post-block:first>.post-header:first>.post-meta').remove();
      {% else %}
        $("#main>.main-inner:first>.content-wrap:first").append("<div id='comments' class='comments' style='opacity:1;padding-top:0px;'></div>");
        gitalk.render('comments');
      {% endif %}
    }
  </script>
{% endif %}

{### Header Font Setting ###}
<style type="text/css">
  @font-face {
    font-family: SignaritaZhaiRhianne;
    src: url("/fonts/signarita_zhai_rhianne-webfont.ttf")
  }
  @font-face {
    font-family: SignaritaZhaiRhianne;
    src: url("/fonts/signarita_zhai_rhianne-webfont.woff")
  }
  @font-face {
    font-family: SignaritaZhaiRhianne;
    src: url("/fonts/signarita_zhai_rhianne-webfont.woff2")
  }
</style>
<script>
  $('#header>.header-inner:first>.site-brand-wrapper:first>.site-meta:first>.custom-logo-site-title:first>.brand:first>.site-title:first').css({'paddingTop':'15px'});
</script>

{### Images Src Redirection ###}
<script>
  $('img').each(function(){
    arr = $(this).attr('alt').split('#');
    if(arr[1] && arr[1].indexOf('postpic/pic') != -1){
      $(this).attr('alt', arr[0]);
      picset = arr[1].substr(11, 1);
      picname = arr[1].substr(12);
      targeturl = "https://raw.githubusercontent.com/lmnsyunhao/blog-pic"+picset+"/master"+picname;
      $(this).attr('src', targeturl);
    }
  })
</script>

{### Load Component ###}
<script>
  {% if config.daovoice %}
    loadcomponent("daovoice", loaddaovoice);
  {% endif %}
  {% if page.comments and config.gitalk.enable %}
    loadcomponent("gitalk", loadgitalk);
  {% endif %}
</script>

{### Change Tag Icon ###}
<script>
  $("a[href^='/tags/'][rel='tag']").each(function(){
    tagName = ($(this).html().split(' '))[1];
    $(this).html("<i class='fa fa-tag'></i> " + tagName);
  })
</script>