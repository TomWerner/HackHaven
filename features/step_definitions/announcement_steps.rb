
 Given /^I am on the Annoucements home page$/ do
  visit announcements_path
 end
 
 When /^I have added an announcement with title "(.*?)" and content "(.*?)"$/ do |title, content|
    pending
    Annoucement.create!(title: title, content: content)    
 end

 Then /^I should see an announcement with title "(.*?)" and content "(.*?)"$/ do |title, content|
    pending 
 end
