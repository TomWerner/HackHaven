//include app/assets/javascripts/announcements_new.js
//= require announcements_new

describe('announcement_new', function() {
  var spys;
  var val = $("#announcement_content");
  beforeEach(function(){
      spys = spyOn(val, 'markdown');
   });
    it("sets up markdown", function() {
        var val2 = val.markdown();
        question_new.setup.value
        expect(val.markdown).toHaveBeenCalled();
    });
});