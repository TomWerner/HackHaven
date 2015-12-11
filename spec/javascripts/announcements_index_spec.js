//include app/assets/javascripts/announcements_index.js
//= require announcements_index
describe('announcement_index', function() {
  var mark;
  var spys;
  beforeEach(function(){
    mark = markdown;
    spyOn(mark, 'toHTML')
  });
  it("calls toHTML", function() {
    var val = mark.toHTML("something");
    question_index.setup();
    expect(mark.toHTML.calls.any()).toEqual(true);
  });
});
