require 'spec_helper'

describe Mobilify do
  after :each do
    @browser.close
  end

  describe "uses default method when given contexts do not apply" do
    Given(:desktop) { KhanAcademy.new(desktop_browser, { :visit => true, :context => [:no_match, :wrong] }) }
    Then { desktop.login_element.inspect.should include("log-in-link ellipsis highlight") }
  end

  describe "uses only applicable context given" do
    context "when applicable context is first in the array" do
      Given(:mobile) { KhanAcademy.new(mobile_browser, { :visit => true, :context => [:mobile, :wrong] }) }
      Then { mobile.login_element.inspect.should include("simple-button big-button") }
    end

    context "when applicable context is second in the array" do
      Given(:mobile) { KhanAcademy.new(mobile_browser, { :visit => true, :context => [:wrong, :mobile] }) }
      Then { mobile.login_element.inspect.should include("simple-button big-button") }
    end
  end

  describe "uses first context given when multiple applicable contexts are given" do
    Given(:mobile) { KhanAcademy.new(mobile_browser, { :visit => true, :context => [:mobile, :ignored] }) }
    Then { mobile.login_element.inspect.should include("simple-button big-button") }
  end
end
