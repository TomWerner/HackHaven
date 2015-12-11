var question_new = {
    setup: function() {
        var value = $("#question_description");
        value.markdown({
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