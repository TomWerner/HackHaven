And /^I click on the button that says "(.*?)"$/ do |title|
    click_button(title)
end

And /^I click on the link that says "(.*?)"$/ do |title|
    click_link(title)
end

Given(/^I have an account and am logged out$/) do
    visit new_user_path
    fill_in 'signup_email', :with => 'Test@email.com'
    fill_in 'signup_name', :with => 'Test User'
    fill_in 'signup_password', :with => 'Pa$$w1rd'
    click_button 'Create my account'
    click_link 'logout'
end

Then(/^I should be able to log in$/) do
    fill_in 'login_email', :with => 'Test@email.com'
    fill_in 'login_password', :with => 'Pa$$w1rd'
    click_button 'Login to my account'
end

And /^I should see "(.*?)"$/ do |title|
    expect(page.body).to have_content(title)
end

Given(/^I clicked on a link to sign up$/) do
    visit new_user_path
end

Then(/^I should be able to fill out the form with the name "(.*?)" to sign up$/) do |arg1|
    fill_in 'signup_email', :with => 'Test@email.com'
    fill_in 'signup_name', :with => arg1
    fill_in 'signup_password', :with => 'Pa$$w1rd'
    click_button 'Create my account'
end