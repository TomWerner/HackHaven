var announcement_index = {
    setup: function() {
    $(document).ready( function() {
    var content = $(".content");
    var admin = $(".adminValue");
    var id = $(".id");
    var i = 0;
    
    for (i = 0; i < content.length; i++) { 
        var el = document.getElementById(id[i].value);
        el.innerHTML = markdown.toHTML(content[i].value);
     }
    } ); 
    }
}