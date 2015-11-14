var question_new = {
    setup: function() {
        $("#question_description").markdown({
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
        });
    }
}