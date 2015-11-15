When /^I have added a registration for contest "(.*?)" with Create Own Team with name "(.*?)"$/ do |contest, name|
    visit registration_index_path
    click_link 'Register For A Contest!'
    click_link 'Register for ' + contest.to_s
    fill_in 'registration_firstname', :with => 'Test'
    fill_in 'registration_lastname', :with => 'Test'
    fill_in 'registration_email', :with => 'Test@email.com'
    fill_in 'registration_year', :with => 'Freshman'
    fill_in 'registration_major', :with => 'Basket Weaving'
    choose 'registration_team_create_own_team'
    fill_in 'registration_newteam', :with => name
    click_button 'Submit'
end

Then /^I should see a team list entry with name "(.*?)"$/ do |team|
    result=false
    all("tr").each do |tr|
        if tr.has_content?(team)
            result = true
            break
        end
    end
    expect(result).to be_truthy
end 

When /^I am on my teams details page$/ do
    visit registration_index_path
    click_on 'View Details'
end

Then /^I should see a list entry with name "(.*?)"$/ do |role|
   result=false
    all("tr").each do |tr|
        if tr.has_content?(role)
            result = true
            break
        end
    end
    expect(result).to be_truthy 
end

Given /^a different user has been logged in$/ do
    click_link 'Logout'
    click_link 'Sign up/Login'
    click_link 'Sign up for an account'
    fill_in 'signup_email', :with => 'Test2@email.com'
    fill_in 'signup_name', :with => 'Test User2'
    fill_in 'signup_password', :with => 'Pa$$w1rd'
    click_button 'Create my account'
end

When /^I have added a registration for contest "(.*?)" with Select Team with name "(.*?)"$/ do |contest, name|
    visit registration_index_path
    click_link 'Register For A Contest!'
    click_link 'Register for ' + contest.to_s
    fill_in 'registration_firstname', :with => 'Test'
    fill_in 'registration_lastname', :with => 'Test'
    fill_in 'registration_email', :with => 'Test@email.com'
    fill_in 'registration_year', :with => 'Freshman'
    fill_in 'registration_major', :with => 'Basket Weaving'
    choose 'registration_team_selected'
    select name, :from => 'registration_selectedteam'
    click_button 'Submit'
end

Given /^a team with name "(.*?)" has been added for "(.*?)"$/ do |name, contest|
    visit registration_index_path
    click_link 'Register For A Contest!'
    click_link 'Register for ' + contest.to_s
    fill_in 'registration_firstname', :with => 'Test'
    fill_in 'registration_lastname', :with => 'Test'
    fill_in 'registration_email', :with => 'Test@email.com'
    fill_in 'registration_year', :with => 'Freshman'
    fill_in 'registration_major', :with => 'Basket Weaving'
    choose 'registration_team_create_own_team'
    fill_in 'registration_newteam', :with => name
    click_button 'Submit'
end

