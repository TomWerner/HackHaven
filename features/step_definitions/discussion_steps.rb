When /^I have added a discussion for question "(.*?)" with title "(.*?)"$/ do |question, disc_title|
    question_id = (Question.find_by_title question).id
    visit new_question_discussion_path(question_id)
    fill_in 'discussion_title', :with => disc_title
    click_button 'submit'
end

When /^I view the discussions for question "(.*?)"$/ do |question|
    question_id = (Question.find_by_title question).id
    visit question_discussions_path(question_id)
end

Then /^I should see a discussion with the title "(.*?)"$/ do |disc_title|
    result=false
    all(".panel").each do |panel|
        if panel.has_content?(disc_title)
            result = true
            break
        end
    end  
    expect(result).to be_truthy
end