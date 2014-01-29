Given /^I am using Firefox$/ do
  @browser = Watir::Browser.new
  @agent = :desktop
end

Given /^I am using a mobile device$/ do
  driver = Webdriver::UserAgent.driver(:browser => :firefox, :agent => :iphone)
  @browser = Watir::Browser.new driver
  @agent = :mobile
end

Given /^I navigate to a Manta profile$/ do
  @page = MantaPage.new(@browser, :context => @agent, :visit => true)
end
