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


When(/^I am an admin$/) do
  visit new_user_path
    fill_in 'signup_email', :with => 'TestUser@email.com'
    fill_in 'signup_name', :with => 'TestUser'
    fill_in 'signup_password', :with => 'Pa$$w1rd'
    click_button 'Create my account'
    
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

When(/^I am on the user page$/) do
  visit users_path
end

And(/^there is a user with the name "(.*?)", the email "(.*?)", and he is "(.*?)"$/) do |arg1, arg2, arg3|

  role = 2 
  if arg3 == "Admin"
      role = 0
  elsif arg3 == "Member"
      role = 1
  end

  user = User.new(:name => arg1, :email => arg2, :admin => role, :password => "passCode")
  user.save
end

When(/^I have edited "(.*?)" with email "(.*?)" to be a "(.*?)"$/) do |arg1, arg2, arg3|
  visit users_path
  text = ""
  if arg3 == "Admin"
    text = "Member"
  elsif arg3 == "Member"
    text = "Admin"
  end
  temp = all(".table tr")
  i=0
  while i< temp.length do
    print temp[i].text
    if temp[i].text.include?(arg1) && temp[i].text.include?(arg2) && temp[i].text.include?(text)
      result = true
      temp[i].click_link "<< View/Edit >>"
      break
    end
    i = i+ 1
  end 
    expect(page.current_path ).to eq(edit_user_path(i))
    expect(page.html).to include(arg1)
    expect(page.html).to include(arg2)
    
    if(arg3 == "Admin")
      choose("user_admin_0") 
    elsif(arg3 == "Member")
      choose("user_admin_1")
    end

    click_button "Update User"
    expect(page.current_path ).to eq(users_path)
end

Then(/^I should view the name "(.*?)", the email "(.*?)", and he is "(.*?)"$/) do |arg1, arg2, arg3|
  result = false
  
  temp = all(".table tr")
  i=0
  while i< temp.length do
    if temp[i].text.include?(arg1) && temp[i].text.include?(arg2) && temp[i].text.include?(arg3)
      result = true
    end
    i = i+ 1
  end 
    expect(result).to be_truthy
end