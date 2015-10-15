
 Given /^I am on the Announcements page$/ do
  visit announcements_path
 end
 
 When /^I have added an announcement with title "(.*?)" and content "(.*?)"$/ do |title, content|
    visit new_announcement_path
    fill_in 'Title', :with => title
    fill_in 'Content', :with => content
    click_button 'Save Changes'   
 end

 Then /^I should see an announcement with title "(.*?)" and content "(.*?)"$/ do |title, content|
    result=false
    all(".panel").each do |panel|
      if panel.has_content?(title) && panel.has_content?(content)
        result = true
       break
      end
   end  
   expect(result).to be_truthy
 end
