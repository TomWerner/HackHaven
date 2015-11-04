Then /^the "(.*?)" tab should be highlighted$/ do |tab|
    result = false
    all("li").each do |list_item|
        if  list_item.has_content?(tab) && list_item[:class].include?("active")
            result = true
        end
    end
    expect(result).to be_truthy
 end
 
 Then /^the "(.*?)" tab should not be highlighted$/ do |tab|
    result = false
    all("li").each do |list_item|
        if  list_item.has_content?(tab) && list_item[:class].include?("active")
            result = true
        end
    end
    expect(result).to be_falsy
 end