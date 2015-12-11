//include app/assets/javascripts/quesions_new.js
//= require questions_new

describe('question_new', function() {
  var spys;
  var val = $("#question_description");
  beforeEach(function(){
      spys = spyOn(val, 'markdown');
   });
    it("sets up markdown", function() {
        var val2 = val.markdown();
        question_new.setup.value
        expect(val.markdown).toHaveBeenCalled();
    });
});