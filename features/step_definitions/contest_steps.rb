When /I have added a contest with contest name "(.*?)"$/ do |contestname|
    visit new_contest_path
    fill_in 'contest_contestname', :with => contestname
    click_button 'Submit'
end

Given /^I am on the Upcoming Contests page$/ do
    visit contests_path
end

Then /^I should see a contest list entry with contest name "(.*?)"$/ do |contest|
    result=false
    all("tr").each do |tr|
        if tr.has_content?(contest)
            result = true
            break
        end
    end
    expect(result).to be_truthy
end