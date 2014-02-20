require 'spec_helper'

describe Mobilify do
  after :each do
    @browser.close
  end

  describe "uses default method when no context is given" do
    Given(:desktop) { KhanAcademy.new(desktop_browser, { :visit => true }) }
    Then { desktop.login_element.inspect.should include("log-in-link ellipsis highlight") }
  end

  describe "uses default method when non-applicable context is given" do
    Given(:desktop) { KhanAcademy.new(desktop_browser, { :visit => true, :context => :wrong }) }
    Then { desktop.login_element.inspect.should include("log-in-link ellipsis highlight") }
  end

  describe "uses contextual method for the given context" do
    Given(:mobile) { KhanAcademy.new(mobile_browser, { :context => :mobile, :visit => true }) }
    Then { mobile.login_element.inspect.should include("simple-button big-button") }
  end
end

