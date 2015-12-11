//include app/assets/javascripts/questions_show.js
//= require questions_show

describe('question_show', function() {
  var mark;
  var spys;
  beforeEach(function(){
    mark = markdown;
    spyOn(mark, 'toHTML')
  });
  it("calls toHTML", function() {
    var val = mark.toHTML("something");
    expect(mark.toHTML.calls.any()).toEqual(true);
  });

});

describe('question_show2', function() {
  var spys;
  var val = $("#custom_results");
  beforeEach(function(){
    spyOn( val , 'show')
  });
  it("display custom testcase results", function(){
    var val2 = val.show();
    question_show.display_custom_testcase_results( new XMLHttpRequest());
    expect(val.show).toHaveBeenCalled();
  });
    
});

describe('question_show3', function(){
  var spys;
  var val = $("#custom_results");
  beforeEach(function(){
     spyOn(val, 'hide')
  });
  it("hide the custom results", function(){
    var val2 = val.hide();
    question_show.setup_custom_testcases();
    expect(val.hide).toHaveBeenCalled();
    
  });
});

describe('question_show4', function(){
  var spys;
  var val = $('#loading-indicator');
  beforeEach(function(){
      spyOn(val, 'hide');
  });
  it("hide loading indicator", function(){
    var val2 = val.hide();
    question_show.setup_loading_element();
    expect(val.hide).toHaveBeenCalled();
    
  });
});


