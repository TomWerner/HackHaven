
 Given /^I am on the Announcements page$/ do
  visit announcements_path
 end
 Given(/^I am an Admin$/) do
    visit new_user_path
    fill_in 'signup_email', :with => 'TestUser@email.com'
    fill_in 'signup_name', :with => 'TestUser'
    fill_in 'signup_password', :with => 'Pa$$w1rd'
    click_button 'Create my account'
    click_button 'Logout'
    
    testVal = User.find_by(name: 'TestUser')
    testVal.admin = 0
    testVal.save
    
    testTwo = User.find_by(name: 'TestUser')

    visit login_path
    fill_in 'login_email', :with => 'TestUser@email.com'
    fill_in 'login_password', :with => 'Pa$$w1rd'
    click_button 'Login to my account'

    expect(page.body).to have_content("TestUser")
    
 end
When(/^I am not signed in$/) do
  
end
 When(/^I am a regular user$/) do
    visit new_user_path
    fill_in 'signup_email', :with => 'TestUser@email.com'
    fill_in 'signup_name', :with => 'TestUser'
    fill_in 'signup_password', :with => 'Pa$$w1rd'
    click_button 'Create my account'
    click_button 'Logout'
    
    
    testTwo = User.find_by(name: 'TestUser')

    visit login_path
    fill_in 'login_email', :with => 'TestUser@email.com'
    fill_in 'login_password', :with => 'Pa$$w1rd'
    click_button 'Login to my account'

    expect(page.body).to have_content("TestUser")
  end

 When /^I have added an announcement with title "(.*?)" and content "(.*?)"$/ do |title, content|
    visit new_announcement_path
    fill_in 'Title', :with => title
    fill_in 'Content', :with => content
    click_button 'Create Announcement' 
 end
 
 When(/^I try to add an announcement with title "(.*?)" and content "(.*?)"$/) do |title, content|
  visit new_announcement_path
  result = false
  
  begin
    field = find_field('Title')
  rescue Capybara::ElementNotFound
    # In Capybara 0.4+ #find_field raises an error instead of returning nil
    result =true
   end
   expect(result).to be(true)
 end

 When /^I have edited the "(.*?)" announcement to have content "(.*?)"$/ do |title, newContent|
    visit announcements_path
    all(".panel").each do |panel|
        if panel.has_content?(title)
            panel.click_link('<< Edit >>')
            fill_in 'Content', :with => newContent
            click_button 'Update Announcement'
            break
        end
    end
 end
 
 When(/^I try to edit the "(.*?)" announcement to have content "(.*?)"$/) do |arg1, arg2|
  visit announcements_path
  result = false
  
  begin
    field = find_link("<< Edit >>")
  rescue Capybara::ElementNotFound
    # In Capybara 0.4+ #find_field raises an error instead of returning nil
    result =true
   end
   expect(result).to be(true)
 end

 Then(/^I should be rediredted to announcement index$/) do
     expect(announcements_path). to eq(page.current_path)
 end

 Then /^I should see an announcement with title "(.*?)" and content "(.*?)"$/ do |title, content|
    result=false
    all(".panel").each do |panel|

        if panel.has_content?(title) && panel.all('p', :text => content)
            result = true
            break
        end
    end  
    expect(result).to be_truthy
 end
