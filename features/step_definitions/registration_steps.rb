Given /a user has been logged in/ do
    visit announcements_path
    click_button 'Sign up/Login'
    click_link 'Sign up for an account'
    fill_in 'signup_email', :with => 'Test@email.com'
    fill_in 'signup_name', :with => 'Test User'
    fill_in 'signup_password', :with => 'Pa$$w1rd'
    click_button 'Create my account'
end

Given /^I am on the Your Registrations page$/ do
    visit registration_index_path
end

When /^I have added a registration with contest name "(.*?)"$/ do |contest|
    visit new_registration_path
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