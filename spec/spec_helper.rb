require 'rspec'
require 'rspec-given'
require 'watir-webdriver'
require 'webdriver-user-agent'
require './lib/mobilify'
require 'support/khan_academy'

def desktop_browser
  @browser = Watir::Browser.new :firefox
end

def mobile_browser
  device = Webdriver::UserAgent.driver(:browser => :firefox, :agent => :iphone)
  @browser = Watir::Browser.new device
end
