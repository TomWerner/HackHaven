var question_index = {
    setup: function() {
        var description = $(".description");
        var id = $(".id");
        var i = 0;
        
        for (i = 0; i < description.length; i++) { 
            var el = document.getElementById(id[i].value);
            el.innerHTML = markdown.toHTML(description[i].value);
        }
    }
}