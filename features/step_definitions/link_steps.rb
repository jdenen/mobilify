When /^I query the map link$/ do
  @query = @page.map?
end

When /^I ask for the map link element$/ do
  @element = @page.map_element
end

When /^I click the map link$/ do
  @page.map
end

Then /^I should receive true$/ do
  @query.should == true
end

Then /^I should receive the desktop link element$/ do
  @element.inspect.should include(':xpath=>"//div[@class=\'panel-body\']//a[contains(@href, \'/cmap/\')]"')
end

Then /^I should receive the mobile link element$/ do
  @element.inspect.should include(':xpath=>"//div[@class=\'col-xs-6\']/a[contains(@href, \'/cmap/\')]"')
end

Then /^I should land on the map page$/ do
  @page.current_url.should include('/cmap/')
end
