var announcement_edit = {
    setup: function() {
        $(document).ready( function() {
      $("#announcement_content").markdown({
        onChange: function(e) {
          var preview = e.$isPreview;
          if(preview)
          {
            $("#submit").hide();
          }
          else
          {
            $("#submit").show();
          }
        }
      })
    });
        
    }
}