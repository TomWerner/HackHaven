
 Given /^I am on the Questions page$/ do
  visit questions_path
 end
 
 When /^I have added a question with title "(.*?)" and description "(.*?)"$/ do |title, description|
    visit new_question_path
    fill_in 'Title', :with => title
    fill_in 'Description', :with => description
    click_button 'Create Question'
 end
 
 When /^I have edited the "(.*?)" question to have description "(.*?)"$/ do |title, newDescription|
    question = Question.find_by_title title
    visit edit_question_path(question)
    fill_in 'Description', :with => newDescription
    click_button 'Update Question'
 end

 Then /^I should see a question with title "(.*?)" and description "(.*?)"$/ do |title, description|
    result=false
    all(".panel").each do |panel|
        if panel.has_content?(title) && panel.has_content?(description)
            result = true
            break
        end
    end  
    expect(result).to be_truthy
 end

When /^I have added a testcase with input "(.*?)" and output "(.*?)" to question "(.*?)"$/ do |input, output, title|
   visit edit_question_path(Question.find_by_title(title))
   click_link 'Add Testcase'
   fill_in 'Standard Input', :with => input
   fill_in 'Standard Output', :with => output
   click_button 'Add Testcase'
end

Then /^I should a testcase with input "(.*?)" and output "(.*?)" on the edit page of "(.*?)"$/ do |input, output, title|
    visit edit_question_path(Question.find_by_title(title))
    result=false
    all("tr").each do |row|
        print(row)
        if row.has_content?(input) && row.has_content?(output)
            result = true
            break
        end
    end  
    expect(result).to be_truthy
end

When /^I have edited the testcase with input "(.*?)" and output "(.*?)" to have output "(.*?)"$/ do |input, output, newOutput|
    testcase = Testcase.find_by_stdin(input)
    visit edit_question_testcase_path(testcase, testcase)
    fill_in 'Standard Input', :with => input
    fill_in 'Standard Output', :with => newOutput
    click_button 'Update Testcase'
end