Given /a user has been logged in/ do
    visit announcements_path
    click_link 'Sign up/Login'
    click_link 'Sign up for an account'
    fill_in 'signup_email', :with => 'Test@email.com'
    fill_in 'signup_name', :with => 'Test User'
    fill_in 'signup_password', :with => 'Pa$$w1rd'
    click_button 'Create my account'
end

Given /a contest has been created with name "(.*?)"$/ do |contestname|
    visit new_contest_path
    fill_in 'contest_contestname', :with => contestname
    click_button 'Submit'
end

Given /^I am on the Your Registrations page$/ do
    visit registration_index_path
end

When /^I have added a registration with contest name "(.*?)"$/ do |contest|
    visit registration_index_path
    click_link 'Register For A Contest!'
    click_link 'Register for ' + contest.to_s
    fill_in 'registration_firstname', :with => 'Test'
    fill_in 'registration_lastname', :with => 'Test'
    fill_in 'registration_email', :with => 'Test@email.com'
    fill_in 'registration_year', :with => 'Freshman'
    fill_in 'registration_major', :with => 'Basket Weaving'
    click_button 'Submit'
end

Given /^I am on the Contest Page$/ do
    visit contests_path
end

When /^I click on the "(.*?)" link$/ do |link_name|
    click_link link_name
end

Then /^I should see a registration list entry with contest name "(.*?)"$/ do |contest|
    result=false
    all("tr").each do |tr|
        if tr.has_content?(contest)
            result = true
            break
        end
    end
    expect(result).to be_truthy
end

When /^I have edited a registration with first name "(.*?)" to have first name "(.*?)"$/ do |name1, name2|
    click_on 'Edit'
    fill_in 'registration_firstname', :with => name2
    click_button 'Submit'
end

When /^I am on the Edit Registration page$/ do
    visit registration_index_path
    click_on 'Edit'
end

Then /^I should see a registration list entry with first name "(.*?)"$/ do |name|
    expect(page).to have_selector("input#registration_firstname[value="+name+"]")
end
