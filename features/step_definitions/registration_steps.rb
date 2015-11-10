Given /a user has been logged in/ do
    visit announcements_path
    click_button 'Sign up/Login'
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
    visit new_registration_path
    fill_in 'registration_firstname', :with => 'Test'
    fill_in 'registration_lastname', :with => 'Test'
    fill_in 'registration_email', :with => 'Test@email.com'
    fill_in 'registration_year', :with => 'Freshman'
    fill_in 'registration_major', :with => 'Basket Weaving'
    select contest, :from => 'registration_contestname'
    click_button 'Submit'
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

When /^I have edited a registration with contest name "(.*?)" to have contest name "(.*?)"$/ do |contest1, contest2|
    click_on 'Edit'
    select contest2, :from => 'registration_contestname'
    click_button 'Submit'
end